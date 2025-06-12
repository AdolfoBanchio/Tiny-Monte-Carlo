#include <math.h>
#include <stdlib.h>
#include <xmmintrin.h> //mul
#include <immintrin.h>
#include <emmintrin.h> //add
#include <smmintrin.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <curand_kernel.h>

#include "params.h"

// Device constants
__constant__ float d_albedo;
__constant__ float d_shells_per_mfp;

// Device function for random number generation
__device__ float get_random(curandState* state) {
    return curand_uniform(state);
}

// Device function for photon simulation
__global__ void photon_kernel(float* heats, float* heats_squared, unsigned int n_photons) {
    // Calculate thread index
    unsigned int tid = blockIdx.x * blockDim.x + threadIdx.x;
    if (tid >= n_photons) return;

    // Initialize random state
    curandState state;
    curand_init(SEED + tid, 0, 0, &state);

    /* launch */
    float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;
    float u = 0.0f;
    float v = 0.0f;
    float w = 1.0f;
    float weight = 1.0f;
    
    for (;;) {
        float t = -logf(get_random(&state)); /* move */
        x += t * u;
        y += t * v;
        z += t * w;

        unsigned int shell = sqrtf(x * x + y * y + z * z) * d_shells_per_mfp; /* absorb */
        if (shell > SHELLS - 1) {
            shell = SHELLS - 1;
        }
        
        // Use atomic operations for thread-safe updates
        float deposit = (1.0f - d_albedo) * weight;
        atomicAdd(&heats[shell], deposit);
        atomicAdd(&heats_squared[shell], deposit * deposit);
        
        weight *= d_albedo;

        /* New direction, rejection method */
        float xi1, xi2;
        do {
            xi1 = 2.0f * get_random(&state) - 1.0f;
            xi2 = 2.0f * get_random(&state) - 1.0f;
            t = xi1 * xi1 + xi2 * xi2;
        } while (1.0f < t);
        
        u = 2.0f * t - 1.0f;
        v = xi1 * sqrtf((1.0f - u * u) / t);
        w = xi2 * sqrtf((1.0f - u * u) / t);

        if (weight < 0.001f) { /* roulette */
            if (get_random(&state) > 0.1f)
                break;
            weight /= 0.1f;
        }
    }
}

// Host function to initialize device constants
void init_device_constants() {
    float h_albedo = MU_S / (MU_S + MU_A);
    float h_shells_per_mfp = 1e4 / MICRONS_PER_SHELL / (MU_A + MU_S);
    
    cudaMemcpyToSymbol(d_albedo, &h_albedo, sizeof(float));
    cudaMemcpyToSymbol(d_shells_per_mfp, &h_shells_per_mfp, sizeof(float));
}