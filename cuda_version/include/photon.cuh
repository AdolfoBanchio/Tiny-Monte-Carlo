#ifndef PHOTON_CUH
#define PHOTON_CUH

#include <cuda_runtime.h>

// Device constants declaration
extern __constant__ float d_albedo;
extern __constant__ float d_shells_per_mfp;

// Host functions declarations
void init_device_constants();

#endif // PHOTON_CUH
