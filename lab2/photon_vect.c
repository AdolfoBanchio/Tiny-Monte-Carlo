#include <math.h>
#include <stdlib.h>
#include <xmmintrin.h> //mul
#include <immintrin.h>
#include <emmintrin.h> //add
#include <smmintrin.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

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
    
    __m256 one = _mm256_set1_ps(1.0f);
    __m256 two = _mm256_set1_ps(2.0f);
    
    __m256 weight = _mm256_set1_ps(1.0f);
    __m256 albedo_v = _mm256_set1_ps(albedo);
    __m256 one_minus_albedo = _mm256_sub_ps(one, albedo_v);
    
    __m256 weight_threshold = _mm256_set1_ps(0.001f);
    __m256 roulette_chance = _mm256_set1_ps(0.1f);
    __m256 roulette_factor = _mm256_set1_ps(10.0f);
    __m256 shells_per_mfp_v = _mm256_set1_ps(shells_per_mfp);

    __m256i active_mask_i = _mm256_set1_epi32(-1);
    __m256 active_mask = _mm256_castsi256_ps(active_mask_i);// Inicialmente todos los fotones están activos

    while (_mm256_movemask_ps(active_mask) != 0) { // Mientras haya fotones activos
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
        x = _mm256_fmadd_ps(t,u,x);
        y = _mm256_fmadd_ps(t,v,y);
        z = _mm256_fmadd_ps(t,w,z);
        // Absorción  ok 
        __m256 x_squared = _mm256_mul_ps(x, x);
        __m256 y_squared = _mm256_mul_ps(y, y);
        __m256 z_squared = _mm256_mul_ps(z, z);
        __m256 dist2 = _mm256_add_ps(x_squared, _mm256_add_ps(y_squared, z_squared));
        __m256 sqrt_dist = _mm256_sqrt_ps(dist2);
        
        //shell_f = sqrt_dist * shells_per_mfp_v
        __m256 shell_f = _mm256_mul_ps(sqrt_dist, shells_per_mfp_v);
 
        // convierto a unsigned int para que no se pierda la parte entera
        __m256i shell = _mm256_cvtps_epi32(shell_f);
        
        // max_shell = vector con el valor máximo de shell
        __m256i max_shell = _mm256_set1_epi32(SHELLS - 1);
        
        // cada elemento de shell se queda con el valor mínimo entre shell y max_shell
        shell = _mm256_min_epi32(shell, max_shell);

        // Peso absorbido 
        __m256 deposit = _mm256_mul_ps(one_minus_albedo, weight);
        __m256 deposit_sq = _mm256_mul_ps(deposit, deposit);

        // Guardar resultados por shell (conversión a escalar porque heats[] no es vectorizable directamente) 
        _Alignas(32) int32_t shell_arr[8];
        _Alignas(32) float deposit_arr[8], deposit_sq_arr[8];
        _mm256_storeu_si256((__m256i *)shell_arr, shell);
        _mm256_storeu_ps(deposit_arr, deposit);
        _mm256_storeu_ps(deposit_sq_arr, deposit_sq);

        float active_arr[8];
        _mm256_storeu_ps(active_arr, active_mask);

        for (int i = 0; i < 8; i++) {  //sólo actualiza la shell para los fotones que están vivos. 
            if (active_arr[i] != 0) { // si el fotón está activo
                // Actualizar heats y heats_squared
                heats[shell_arr[i]] += deposit_arr[i];
                heats_squared[shell_arr[i]] += deposit_sq_arr[i];
            }
        }

        // Actualizar pesos 
        weight = _mm256_mul_ps(weight, albedo_v);

        // Nueva dirección, proceso cada linea independientemente
        // para asi evitar el uso de mascara e ejecucion de instrucciones 
        // ineficientes en lineas ya terminadas.
        _Alignas(32) float xi1_arr[8] = {0}, xi2_arr[8] = {0}, t_reject_arr[8] = {0};
        // proceso cada foton
        for (int i = 0; i < 8; i++) {
            float xi1_local,xi2_local, t_local;
            do{
                xi1_local = 2.0f * (pcg32_random() / (float)UINT32_MAX) - 1.0f;
                xi2_local = 2.0f * (pcg32_random() / (float)UINT32_MAX) - 1.0f;
                t_local = xi1_local * xi1_local + xi2_local * xi2_local;
            } while (1.0f < t_local);
            xi1_arr[i] = xi1_local;
            xi2_arr[i] = xi2_local;
            t_reject_arr[i] = t_local;
        }
        // Cargar los resultados en un vector
        __m256 xi1 = _mm256_loadu_ps(xi1_arr);
        __m256 xi2 = _mm256_loadu_ps(xi2_arr);
        __m256 t_reject = _mm256_loadu_ps(t_reject_arr);
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
        __m256 weight_trld_mask = _mm256_cmp_ps(weight, weight_threshold, _CMP_LT_OQ);
        // en cada linea tengo 0xFFFFFFFF o 0

        // a los fotones que pasaron el umbral de peso, los someto a una ruleta rusa
        __m256 rand_ps = rand_vector_256();
        // mascara para los fotones que perdieron en la ruleta
        __m256 roulette_mask = _mm256_cmp_ps(rand_ps, roulette_chance, _CMP_GT_OQ);
        // en cada linea tengo 0xFFFFFFFF o 0

        // si pasaron el umbral y perdieron en la ruleta, muere el foton
        __m256 terminate_mask = _mm256_and_ps(weight_trld_mask, roulette_mask);
        // se que tendre valores 0xFFFFFFFF o 0, debido a como cree las mascaras usadas

        // si el foton muere, lo marco como inactivo. Puedo usar con seguirdad
        // esta funcion debido a que conozco los posibles valores de terminate_mask
        active_mask = _mm256_blendv_ps(active_mask, _mm256_setzero_ps(), terminate_mask);

        // actualizo peso de fotones que pasaron el umbral pero sobrevivieron a la ruleta
        __m256 weight_survivers = _mm256_andnot_ps(roulette_mask, weight_trld_mask);
        
        // multiplico por roulette_factor a los que sobrevivieron a la ruleta
        __m256 adjusted_weight = _mm256_mul_ps(weight, roulette_factor);
        weight = _mm256_blendv_ps(weight, adjusted_weight, weight_survivers);
    }
}