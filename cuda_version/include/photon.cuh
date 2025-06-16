#ifndef PHOTON_CUH
#define PHOTON_CUH

#include <cuda_runtime.h>
#include <curand_kernel.h>

// Host functions declarations
void init_device_constants();
__global__ void photon_kernel(float* heats, float* heats_squared, curandState* states);
__global__ void init_rng_kernel(curandState *states, unsigned long seed);

#endif // PHOTON_CUH
