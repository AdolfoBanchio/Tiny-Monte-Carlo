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

//Función que retorna una máscara de 512bits 
__m512 cmp_lt_ps_allbits(__m512 a, __m512 b) {
    __mmask16 mask = _mm512_cmp_ps_mask(a, b, _CMP_LT_OS);

    // Lleno de bits en 1 → equivale a (float)0xFFFFFFFF, es decir, -nan
    __m512 all_ones = _mm512_castsi512_ps(_mm512_set1_epi32(-1)); // 0xFFFFFFFF
    __m512 zeros = _mm512_setzero_ps();

    return _mm512_mask_blend_ps(mask, zeros, all_ones);
}

//Función que retorna una máscara de 512bits 
__m512 cmp_gt_ps_allbits(__m512 a, __m512 b) {
    __mmask16 mask = _mm512_cmp_ps_mask(a, b, _CMP_GT_OS);

    // Lleno de bits en 1 → equivale a (float)0xFFFFFFFF, es decir, -nan
    __m512 all_ones = _mm512_castsi512_ps(_mm512_set1_epi32(-1)); // 0xFFFFFFFF
    __m512 zeros = _mm512_setzero_ps();

    return _mm512_mask_blend_ps(mask, zeros, all_ones);
}


// Simula generación de vector de floats aleatorios entre 0 y 1
__m512 rand_vector_512(pcg32_random_t* rng) {
    float r[16];
    for (int i = 0; i < 16; i++)
        r[i] = pcg32_random_r(rng) / (float)RAND_MAX;  
    return _mm512_loadu_ps(r);
}


void photon(float* heats, float* heats_squared)
{
    __m512 x = _mm512_setzero_ps();
    __m512 y = _mm512_setzero_ps();
    __m512 z = _mm512_setzero_ps();
    __m512 u = _mm512_setzero_ps();
    __m512 v = _mm512_setzero_ps();
    __m512 w = _mm512_set1_ps(1.0f);
    __m512 weight = _mm512_set1_ps(1.0f);
    __m512 albedo_v = _mm512_set1_ps(albedo);

    __m512 one = _mm512_set1_ps(1.0f);
    __m512 two = _mm512_set1_ps(2.0f);
    __m512 weight_threshold = _mm512_set1_ps(0.001f);
    __m512 roulette_chance = _mm512_set1_ps(0.1f);
    __m512 roulette_factor = _mm512_set1_ps(10.0f);
    __m512 shells_per_mfp_v = _mm512_set1_ps(shells_per_mfp);

    __m512 active_mask = _mm512_set1_ps(1.0f); // 1.0 = activo, 0.0 = muerto
    bool any_active = true;

    pcg32_random_t rng;
    pcg32_srandom_r(&rng, 42u, 54u);

    while (any_active) {
        // t = -log(rand)     
        float randf[16];
        for (int i = 0; i < 16; i++) randf[i] = -logf(pcg32_random_r(&rng) / (float)UINT32_MAX);
        __m512 t = _mm512_loadu_ps(randf);

        // Aplicar máscaras  
        __m512 t_masked = _mm512_mul_ps(t, active_mask);

        // Movimiento  ok   
        x = _mm512_add_ps(x, _mm512_mul_ps(t_masked, u));
        y = _mm512_add_ps(y, _mm512_mul_ps(t_masked, v));
        z = _mm512_add_ps(z, _mm512_mul_ps(t_masked, w));

        // Absorción  ok 
        __m512 dist2 = _mm512_fmadd_ps(x, x, _mm512_fmadd_ps(y, y, _mm512_mul_ps(z, z)));
        __m512 sqrt_dist = _mm512_sqrt_ps(dist2);
        __m512 shell_f = _mm512_mul_ps(sqrt_dist, shells_per_mfp_v);
        __m512i shell = _mm512_cvtps_epu32(shell_f);
        __m512i max_shell = _mm512_set1_epi32(SHELLS - 1);
        shell = _mm512_min_epu32(shell, max_shell);

        // Peso absorbido 
        __m512 deposit = _mm512_mul_ps(_mm512_sub_ps(one, albedo_v), weight);
        __m512 deposit_sq = _mm512_mul_ps(deposit, deposit);

        // Guardar resultados por shell (conversión a escalar porque heats[] no es vectorizable directamente) 
        uint32_t shell_arr[16];
        float deposit_arr[16], deposit_sq_arr[16], active_arr[16];
        _mm512_storeu_si512(shell_arr, shell);
        _mm512_storeu_ps(deposit_arr, deposit);
        _mm512_storeu_ps(deposit_sq_arr, deposit_sq);
        _mm512_storeu_ps(active_arr, active_mask);

        for (int i = 0; i < 16; i++) {  //sólo actualiza la shell para los fotones que están vivos. 
            if (active_arr[i] != 0.0f) {
                heats[shell_arr[i]] += deposit_arr[i];
                heats_squared[shell_arr[i]] += deposit_sq_arr[i];
            }
        }

        // Actualizar pesos 
        weight = _mm512_mul_ps(weight, albedo_v);

        // Nueva dirección 
        __m512 xi1, xi2, t_reject;
        __mmask16 done_mask = 0;
        xi1 = xi2 = t_reject = _mm512_setzero_ps();

        while (done_mask != 0xFFFF) {  //done_mask == FFFF cuando todos los lanes cumplen q el t calculado para ese lane 1.0 > t 
            float r1[16], r2[16];
             for (int i = 0; i < 16; i++) {
                r1[i] = 2.0f * (pcg32_random_r(&rng) / (float)RAND_MAX) - 1.0f;   
                r2[i] = 2.0f * (pcg32_random_r(&rng) / (float)RAND_MAX) - 1.0f;
            }

            __m512 new_xi1 = _mm512_loadu_ps(r1); 
            __m512 new_xi2 = _mm512_loadu_ps(r2);   
            __m512 new_t = _mm512_add_ps(         
                _mm512_mul_ps(new_xi1, new_xi1),
                _mm512_mul_ps(new_xi2, new_xi2)
            );

            __mmask16 accept_mask = _mm512_cmp_ps_mask(new_t, one, _CMP_LT_OQ);
            accept_mask = accept_mask & ~done_mask;

            xi1 = _mm512_mask_blend_ps(accept_mask, xi1, new_xi1);
            xi2 = _mm512_mask_blend_ps(accept_mask, xi2, new_xi2);
            t_reject = _mm512_mask_blend_ps(accept_mask, t_reject, new_t);

            done_mask |= accept_mask;
        }

        // u = 2t - 1  
        u = _mm512_sub_ps(_mm512_mul_ps(two, t_reject), one);

        // sqrt_term = sqrt((1 - u*u)/t)  
        __m512 u2 = _mm512_mul_ps(u, u);
        __m512 tmp = _mm512_div_ps(_mm512_sub_ps(one, u2), t_reject);
        __m512 sqrt_term = _mm512_sqrt_ps(tmp);

        // v = xi1 * sqrt(...)
        v = _mm512_mul_ps(xi1, sqrt_term);
        w = _mm512_mul_ps(xi2, sqrt_term);

        // Ruleta rusa
        __m512 weight_mask = cmp_lt_ps_allbits(weight, weight_threshold);
        __m512 rand_ps = rand_vector_512(&rng);
        __m512 rand_mask = cmp_gt_ps_allbits(rand_ps, roulette_chance);
        __m512 terminate_mask = _mm512_and_ps(weight_mask, rand_mask);
        active_mask = _mm512_andnot_ps(terminate_mask, active_mask);

        __m512 survive_mask = _mm512_and_ps(weight_mask, _mm512_andnot_ps(terminate_mask, active_mask));
        __m512 boosted = _mm512_mul_ps(weight, roulette_factor);
        weight = _mm512_add_ps(
            _mm512_andnot_ps(survive_mask, weight),
            _mm512_and_ps(survive_mask, boosted)
        );

        // ¿Queda algún fotón vivo?
        int active_bits = _mm512_movepi32_mask(_mm512_castps_si512(active_mask));
        any_active = (active_bits != 0);
    }
}