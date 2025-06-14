#include <math.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <curand_kernel.h>

#include "params.cuh"

// Device constants
__constant__ float d_albedo;
__constant__ float d_shells_per_mfp;

// Initialize random number generator state for each photon
__global__ void init_rng_kernel(curandState *states, unsigned long seed) {
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    if (tid < PHOTONS) {
        curand_init(seed, tid, 0, &states[tid]);
    }
}

// Device function for photon simulation
__global__ void photon_kernel(float* heats, float* heats_squared,curandState* states) {
    // Calculate thread index
    unsigned int tid = blockIdx.x * blockDim.x + threadIdx.x;
    if (tid >= PHOTONS) return;

    // Initialize random state
    curandState state = states[tid];

    float* heat_tid = heats +(size_t)SHELLS* (size_t)tid;
    float* heat2_tid = heats_squared +(size_t)SHELLS*(size_t)tid;

    /* launch */
    float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;
    float u = 0.0f;
    float v = 0.0f;
    float w = 1.0f;
    float weight = 1.0f;
    
    for (;;) {
        float t = -logf(curand_uniform(&state)); /* move */
        x += t * u;
        y += t * v;
        z += t * w;

        unsigned int shell = sqrtf(x * x + y * y + z * z) * d_shells_per_mfp; /* absorb */
        if (shell > SHELLS - 1) {
            shell = SHELLS - 1;
        }
        
        // Use atomic operations for thread-safe updates
        float deposit = (1.0f - d_albedo) * weight;
        heat_tid[shell]= deposit;
        heat2_tid[shell] = deposit * deposit;
        
        weight *= d_albedo;

        /* New direction, rejection method */
        float xi1, xi2;
        do {
            xi1 = 2.0f * curand_uniform(&state) - 1.0f;
            xi2 = 2.0f * curand_uniform(&state) - 1.0f;
            t = xi1 * xi1 + xi2 * xi2;
        } while (1.0f < t);
        
        u = 2.0f * t - 1.0f;
        v = xi1 * sqrtf((1.0f - u * u) / t);
        w = xi2 * sqrtf((1.0f - u * u) / t);

        if (weight < 0.001f) { /* roulette */
            if (curand_uniform(&state) > 0.1f)
                break;
            weight /= 0.1f;
        }
    }

    // Store the final state back to the states array
    states[tid] = state;
}

// Host function to initialize device constants
void init_device_constants() {
    float h_albedo = MU_S / (MU_S + MU_A);
    float h_shells_per_mfp = 1e4 / MICRONS_PER_SHELL / (MU_A + MU_S);
    
    cudaMemcpyToSymbol(d_albedo, &h_albedo, sizeof(float));
    cudaMemcpyToSymbol(d_shells_per_mfp, &h_shells_per_mfp, sizeof(float));
}
