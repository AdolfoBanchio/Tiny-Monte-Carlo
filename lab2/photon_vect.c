#include <math.h>
#include <stdlib.h>
#include <xmmintrin.h> //mul
#include <immintrin.h>
#include <emmintrin.h> //add
#include <smmintrin.h>
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
    /* float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;
    float u = 0.0f;
    float v = 0.0f;
    float w = 1.0f;
     */
    float weight = 1.0f;
    float t;
    //vector <0,u,v,w>
    __m128 vector_uvw = _mm_set_ps(0.0f,0.0f,0.0f,1.0f); //primer coordenada no me importa
    
    //vector <0,x,y,z>
    __m128 vector_xyz = _mm_set_ps(0.0f,0.0f,0.0f,0.0f);
    for (;;) {
        t = -logf(pcg32_random() / (float)UINT32_MAX); /* move */    //Modificar acá porque genera todos los lanes con el mismo valor t 
        //vector con <t,t,t,t>
        __m128 vector_t =  _mm_set_ps1(t);
        
        // x += t * u;
        // y += t * v;
        // z += t * w;
        //vector <0*t,u*t,v*t,w*t>
        __m128 vector_mul = _mm_mul_ps (vector_uvw, vector_t);
        
        //vector <0*t + 0,u*t + x,v*t + y,w*t + z> 
        vector_xyz = _mm_add_ps(vector_xyz, vector_mul);

        /* 
            La funcion calcula el producto vectorial entre dos 
            vectores de 4 elementos. el 3er argumento especifica:
            
            que elementos de los vectores seran incluidos en el calculo del dp [7:4]
            y en que lugar del vector resultante se guardara el resultado [3:0]
            0x71 = 0111 0001, 
            usa los 3 elementos menos significativos para el calculo del dp (xyz)
            guarda el resutlado en el elemento menos singificativo del vector resultante.
            por eso lo leo usando cvtss.

            dp = x*x + y*y + z*z
         */
        float dp =  _mm_cvtss_f32(_mm_dp_ps(vector_xyz, vector_xyz, 0x71));


        unsigned int shell = sqrtf(dp) * shells_per_mfp; /* absorb */
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
