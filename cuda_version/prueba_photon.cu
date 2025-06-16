#include <math.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <curand_kernel.h>

#include "params.cuh"

#define WARP_SIZE 32
#define THREADS_PER_BLOCK 128 //Cambiar
#define WARPS_PER_BLOCK (THREADS_PER_BLOCK / WARP_SIZE)

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

__global__ void photon_kernel(float* heats, float* heats_squared, curandState* states) {
    // Índices
    unsigned int tid = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned int warp_id = threadIdx.x / WARP_SIZE;
    unsigned int lane_id = threadIdx.x % WARP_SIZE;

    if (tid >= PHOTONS) return;

    // Shared memory
    __shared__ float warp_heat[WARPS_PER_BLOCK][SHELLS];
    __shared__ float warp_heat2[WARPS_PER_BLOCK][SHELLS];

    // Inicializar todos los valores en 0.0 (paralelamente)
    for (int i = threadIdx.x; i < WARPS_PER_BLOCK * SHELLS; i += blockDim.x) {
        int w = i / SHELLS;
        int s = i % SHELLS;
        warp_heat[w][s] = 0.0f;
        warp_heat2[w][s] = 0.0f;
    }

    __syncthreads();  // Asegurar que todos inicialicen

    // RNG local
    curandState state = states[tid];

    // Variables del fotón
    float x = 0.0f, y = 0.0f, z = 0.0f;
    float u = 0.0f, v = 0.0f, w = 1.0f;
    float weight = 1.0f;

    for (;;) {
        float t = -logf(curand_uniform(&state)); // move
        x += t * u;
        y += t * v;
        z += t * w;

        unsigned int shell = fminf(float(SHELLS - 1), sqrtf(x * x + y * y + z * z) * d_shells_per_mfp);

        float deposit = (1.0f - d_albedo) * weight;

        // Acumular localmente por warp y shell (no atomic necesario dentro del mismo warp)
        atomicAdd(&warp_heat[warp_id][shell], deposit);
        atomicAdd(&warp_heat2[warp_id][shell], deposit * deposit);

        weight *= d_albedo;

        // Rechazo
        float xi1, xi2;
        do {
            xi1 = 2.0f * curand_uniform(&state) - 1.0f;
            xi2 = 2.0f * curand_uniform(&state) - 1.0f;
            t = xi1 * xi1 + xi2 * xi2;
        } while (1.0f < t);

        u = 2.0f * t - 1.0f;
        v = xi1 * sqrtf((1.0f - u * u) / t);
        w = xi2 * sqrtf((1.0f - u * u) / t);

        if (weight < 0.001f) {
            if (curand_uniform(&state) > 0.1f)
                break;
            weight /= 0.1f;
        }
    }

    states[tid] = state;

    __syncthreads(); // Todos deben haber terminado de escribir en warp_heat antes de reducir

    // Hilos 0..SHELLS-1 hacen la reducción final (uno por posición)
    if (threadIdx.x < SHELLS) {
        float sum = 0.0f;
        float sum2 = 0.0f;
        for (int w = 0; w < WARPS_PER_BLOCK; ++w) {
            sum += warp_heat[w][threadIdx.x];
            sum2 += warp_heat2[w][threadIdx.x];
        }

        // Solo un bloque, o hacer atomicAdd si múltiples bloques
        heats[threadIdx.x] = sum;
        heats_squared[threadIdx.x] = sum2;
    }
}


void init_device_constants() {
    float h_albedo = MU_S / (MU_S + MU_A);
    float h_shells_per_mfp = 1e4 / MICRONS_PER_SHELL / (MU_A + MU_S);
    
    cudaMemcpyToSymbol(d_albedo, &h_albedo, sizeof(float));
    cudaMemcpyToSymbol(d_shells_per_mfp, &h_shells_per_mfp, sizeof(float));
}
