#include <math.h>
#include <stdlib.h>
#include <xmmintrin.h> //mul
#include <immintrin.h>
#include <emmintrin.h> //add
#include <smmintrin.h>
#include <stdbool.h>

#include "params.h"
#include "pcg_basic.h"

const float albedo = MU_S / (MU_S + MU_A);
const float shells_per_mfp = 1e4 / MICRONS_PER_SHELL / (MU_A + MU_S);

// Simula generación de vector de floats aleatorios entre 0 y 1
__m256 rand_vector_256() {
    float r[8];
    for (int i = 0; i < 8; i++)
        r[i] = pcg32_random() / (float)RAND_MAX;  
    return _mm256_loadu_ps(r);
}


void photon(float* heats, float* heats_squared)
{
    __m256 x = _mm256_setzero_ps();
    __m256 y = _mm256_setzero_ps();
    __m256 z = _mm256_setzero_ps();
    __m256 u = _mm256_setzero_ps();
    __m256 v = _mm256_setzero_ps();
    __m256 w = _mm256_set1_ps(1.0f);
    __m256 weight = _mm256_set1_ps(1.0f);
    __m256 albedo_v = _mm256_set1_ps(albedo);

    __m256 one = _mm256_set1_ps(1.0f);
    __m256 two = _mm256_set1_ps(2.0f);
    __m256 weight_threshold = _mm256_set1_ps(0.001f);
    __m256 roulette_chance = _mm256_set1_ps(0.1f);
    __m256 roulette_factor = _mm256_set1_ps(10.0f);
    __m256 shells_per_mfp_v = _mm256_set1_ps(shells_per_mfp);

    __mmask8 active_mask = 0xFF; // Inicialmente todos los fotones están activos
    bool any_active = true;

    while (active_mask != 0) { // Mientras haya fotones activos
        // t = -log(rand)     
        float randf[8];
        for (int i = 0; i < 8; i++) randf[i] = -logf(pcg32_random() / (float)UINT32_MAX);
        __m256 t = _mm256_loadu_ps(randf);

        /* // Aplicar máscaras  
        __m256 t_masked = _mm256_mul_ps(t, active_mask);
        
        puedo eliminar esta linea porque luego en el loop de update
        solo se utilizan los t que estan activos
        
        */
        // Movimiento  ok   
        x = _mm256_add_ps(x, _mm256_mul_ps(t, u));
        y = _mm256_add_ps(y, _mm256_mul_ps(t, v));
        z = _mm256_add_ps(z, _mm256_mul_ps(t, w));

        // Absorción  ok 
        __m256 dist2 = _mm256_fmadd_ps(x, x, _mm256_fmadd_ps(y, y, _mm256_mul_ps(z, z)));
        __m256 sqrt_dist = _mm256_sqrt_ps(dist2);
        
        //shell_f = sqrt_dist * shells_per_mfp_v
        __m256 shell_f = _mm256_mul_ps(sqrt_dist, shells_per_mfp_v);
 
        // convierto a unsigned int para que no se pierda la parte entera
        __m256i shell = _mm256_cvtps_epu32(shell_f);
        
        // max_shell = vector con el valor máximo de shell
        __m256i max_shell = _mm256_set1_epi32(SHELLS - 1);
        
        // cada elemento de shell se queda con el valor mínimo entre shell y max_shell
        shell = _mm256_min_epu32(shell, max_shell);

        // Peso absorbido 
        __m256 deposit = _mm256_mul_ps(_mm256_sub_ps(one, albedo_v), weight);
        __m256 deposit_sq = _mm256_mul_ps(deposit, deposit);

        // Guardar resultados por shell (conversión a escalar porque heats[] no es vectorizable directamente) 
        uint32_t shell_arr[8];
        float deposit_arr[8], deposit_sq_arr[8], active_arr[8];
        _mm256_storeu_si256(shell_arr, shell);
        _mm256_storeu_ps(deposit_arr, deposit);
        _mm256_storeu_ps(deposit_sq_arr, deposit_sq);
        __m256 active_mask_ps = _mm256_castsi256_ps(_mm256_set1_epi32(active_mask));
        _mm256_storeu_ps(active_arr, active_mask_ps);

        for (int i = 0; i < 8; i++) {  //sólo actualiza la shell para los fotones que están vivos. 
            if (active_arr[i]) {
                // Actualizar heats y heats_squared
                heats[shell_arr[i]] += deposit_arr[i];
                heats_squared[shell_arr[i]] += deposit_sq_arr[i];
            }
        }

        // Actualizar pesos 
        weight = _mm256_mul_ps(weight, albedo_v);

        // Nueva dirección 
        __m256 xi1, xi2, t_reject;
        __mmask8 done_mask = 0;
        xi1 = xi2 = t_reject = _mm256_setzero_ps();

        while (done_mask != 0xFF) {  //done_mask == FF cuando todos los lanes cumplen q el t calculado para ese lane 1.0 > t 
            float r1[8], r2[8];
             for (int i = 0; i < 8; i++) {
                r1[i] = 2.0f * (pcg32_random() / (float)RAND_MAX) - 1.0f;   
                r2[i] = 2.0f * (pcg32_random() / (float)RAND_MAX) - 1.0f;
            }

            __m256 new_xi1 = _mm256_loadu_ps(r1); 
            __m256 new_xi2 = _mm256_loadu_ps(r2);   
            __m256 new_t = _mm256_add_ps(         
                _mm256_mul_ps(new_xi1, new_xi1),
                _mm256_mul_ps(new_xi2, new_xi2)
            );

            __mmask8 accept_mask = _mm256_cmp_ps_mask(new_t, one, _CMP_LE_OQ);
            accept_mask = accept_mask & ~done_mask;

            xi1 = _mm256_mask_blend_ps(accept_mask, xi1, new_xi1);
            xi2 = _mm256_mask_blend_ps(accept_mask, xi2, new_xi2);
            t_reject = _mm256_mask_blend_ps(accept_mask, t_reject, new_t);

            done_mask |= accept_mask;
        }

        // u = 2t - 1  
        u = _mm256_sub_ps(_mm256_mul_ps(two, t_reject), one);

        // sqrt_term = sqrt((1 - u*u)/t)  
        __m256 u_square = _mm256_mul_ps(u, u);
        __m256 tmp = _mm256_div_ps(_mm256_sub_ps(one, u_square), t_reject);
        __m256 sqrt_term = _mm256_sqrt_ps(tmp);

        // v = xi1 * sqrt(...)
        v = _mm256_mul_ps(xi1, sqrt_term);
        w = _mm256_mul_ps(xi2, sqrt_term);

        // Ruleta rusa
        // creo una mascara por los fotones que pasaron el umbral de peso
        __mmask8 weight_trld_mask = _mm256_cmp_ps_mask(weight, weight_threshold, _CMP_LT_OQ);
        
        // a los fotones que pasaron el umbral de peso, los someto a una ruleta rusa
        __m256 rand_ps = rand_vector_256();
        // mascara para los fotones que perdieron en la ruleta
        __mmask8 roulette_mask = _mm256_cmp_ps_mask(rand_ps, roulette_chance, _CMP_GT_OQ);
        
        // si pasaron el umbral y perdieron en la ruleta, muere el foton
        __mmask8 terminate_mask = weight_trld_mask & roulette_mask;
        // ~terminate_mask, tendra 1 en los fotones que no murieron
        // entonces si no murio y esta activo, se queda activo. cc muere
        active_mask = active_mask & ~terminate_mask;

        // actualizo peso de fotones que pasaron el umbral pero sobrevivieron a la ruleta
        __mmask8 weight_survivers = weight_trld_mask & ~roulette_mask;
        // weight_survivers, tendra 1 en los fotones que pasaron el umbral y sobrevivieron a la ruleta
        // multiplico por roulette_factor a los que sobrevivieron a la ruleta
        weight = _mm256_mask_mul_ps(weight, weight_survivers, weight, roulette_factor);
    }
}