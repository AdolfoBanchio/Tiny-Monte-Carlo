#include <math.h>
#include <stdlib.h>
#include <xmmintrin.h> //mul
#include <immintrin.h>
#include <emmintrin.h> //add
#include "pcg_basic.h" // Add this include
#include "params.h"

const float albedo = MU_S / (MU_S + MU_A);
const float shells_per_mfp = 1e4 / MICRONS_PER_SHELL / (MU_A + MU_S);

void photon(float* heats, float* heats_squared)
{
    /* Initialize PCG RNG */
    pcg32_random_t rng;
    pcg32_srandom_r(&rng, 42u, 54u); // Initialize with seed values

    /* launch */
    float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;
    float u = 0.0f;
    float v = 0.0f;
    float w = 1.0f;
    float weight = 1.0f;
    
    for (;;) {
        float t = -logf(pcg32_random_r(&rng) / (float)UINT32_MAX); /* move */
        // x += t * u;
        // y += t * v;
        // z += t * w;

        //corregir acá para que agarre los valores de los vectores una vez q haga el loop

        //vector con <t,t,t,t>
        __m128 vector_t =  _mm_set_ps1(t);
        
        //vector <0,u,v,w>
        __m128 vector_uvw = _mm_set_ps(0.0f,u,v,w); //primer coordenada no me importa
        
        //vector <0,x,y,z>
        __m128 vector_xyz = _mm_set_ps(0.0f,x,y,z);
        
        //vector <0*t,u*t,v*t,w*t>
        __m128 vector_mul = _mm_mul_ps (vector_uvw, vector_t);
        
        //vector <0*t + 0,u*t + x,v*t + y,w*t + z> 
        vector_xyz = _mm_add_ps(vector_xyz, vector_mul);

        //vector <0,x*x, y*y, z*z>
        __m128 vector_xyz_cuad =  _mm_mul_ps(vector_xyz, vector_xyz);

        //sumo los elementos del vector para obtener la distancia 
        __m128 vector_cero = _mm_set_ps1(0.0f);
        __m128 vector_suma = _mm_hadd_ps(vector_xyz_cuad,vector_cero);  
        vector_suma = _mm_hadd_ps(vector_suma,vector_cero);
    
        //extraigo los 32 bits menos significativos, donde se almacena x * x + y * y + z * z
        float dist =  _mm_cvtss_f32 (vector_suma);  

        unsigned int shell = sqrtf(dist) * shells_per_mfp; /* absorb */
        if (shell > SHELLS - 1) {
            shell = SHELLS - 1;
        }
        heats[shell] += (1.0f - albedo) * weight;
        heats_squared[shell] += (1.0f - albedo) * (1.0f - albedo) * weight * weight; /* add up squares */
        weight *= albedo;

        /* New direction, rejection method */
        float xi1, xi2;
        do {
            xi1 = 2.0f * pcg32_random_r(&rng) / (float)UINT32_MAX - 1.0f;
            xi2 = 2.0f * pcg32_random_r(&rng) / (float)UINT32_MAX - 1.0f;
            t = xi1 * xi1 + xi2 * xi2;
 
            vector_t = _mm_set_ps1(t);            
            //ver si se puede acceder a el valor de t así no tenemos q calcularlo 2 veces 
        } while (1.0f < t);

        // u = 2.0f * t - 1.0f;
        // v = xi1 * sqrtf((1.0f - u * u) / t);
        // w = xi2 * sqrtf((1.0f - u * u) / t);    ver si se puede mejorar los valores 

        vector_uvw =  _mm_set_ps(0.0f,
                                2.0f * t - 1.0f,
                                xi1 * sqrtf((1.0f - 2.0f * t - 1.0f * 2.0f * t - 1.0f) / t),     
                                xi2 * sqrtf((1.0f - 2.0f * t - 1.0f * 2.0f * t - 1.0f) / t));

        if (weight < 0.001f) { /* roulette */
            if (pcg32_random_r(&rng) / (float)UINT32_MAX > 0.1f)
                break;
            weight /= 0.1f;
        }
    }
}
