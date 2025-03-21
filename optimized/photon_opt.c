#include <math.h>
#include <stdlib.h>

#include "params.h"
#include "SFMT.h"
#include "pcg_basic.h"

const float albedo = MU_S / (MU_S + MU_A);
const float shells_per_mfp = 1e4 / MICRONS_PER_SHELL / (MU_A + MU_S);
sfmt_t sfmt;

void photon_opt(float* heats, float* heats_squared)
{
    /* launch */
    float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;
    float u = 0.0f;
    float v = 0.0f;
    float w = 1.0f;
    float weight = 1.0f;
    
    //sfmt_init_gen_rand(&sfmt, SEED); 
    for (;;) {
        float t = -logf(pcg32_boundedrand(RAND_MAX)/ (float)RAND_MAX); /* move */
        x += t * u;
        y += t * v;
        z += t * w;

        unsigned int shell = sqrtf(x * x + y * y + z * z) * shells_per_mfp; /* absorb */
        if (shell > SHELLS - 1) {
            shell = SHELLS - 1;
        }
        heats[shell] += (1.0f - albedo) * weight;
        heats_squared[shell] += (1.0f - albedo) * (1.0f - albedo) * weight * weight; /* add up squares */
        weight *= albedo;

        /* New direction, rejection method */
        float xi1, xi2;
        do {
            xi1 = 2.0f * pcg32_boundedrand(RAND_MAX) / (float)RAND_MAX - 1.0f;
            xi2 = 2.0f * pcg32_boundedrand(RAND_MAX) / (float)RAND_MAX - 1.0f;
            t = xi1 * xi1 + xi2 * xi2;
        } while (1.0f < t);
        u = 2.0f * t - 1.0f;
        v = xi1 * sqrtf((1.0f - u * u) / t);
        w = xi2 * sqrtf((1.0f - u * u) / t);

        if (weight < 0.001f) { /* roulette */
            if (pcg32_boundedrand(RAND_MAX) / (float)RAND_MAX > 0.1f)
                break;
            weight /= 0.1f;
        }
    }
}
