#ifndef PHOTON_CUH
#define PHOTON_CUH

#include <cuda_runtime.h>

// Device constants declaration
extern __constant__ float d_albedo;
extern __constant__ float d_shells_per_mfp;

// Host functions declarations
void init_device_constants();
__global__ void photon_kernel(float* heats, float* heats_squared, unsigned int n_photons); 
#endif // PHOTON_CUH
