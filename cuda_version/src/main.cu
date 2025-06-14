/* Tiny Monte Carlo by Scott Prahl (http://omlc.ogi.edu)"
 * 1 W Point Source Heating in Infinite Isotropic Scattering Medium
 * http://omlc.ogi.edu/software/mc/tiny_mc.c
 *
 * Adaptado para CP2014, Nicolas Wolovick
 */

#define _XOPEN_SOURCE 500 // M_PI

#include "params.cuh"
#include "photon.cuh"
#include "wtime.cuh"

#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <curand_kernel.h>

char t1[] = "Tiny Monte Carlo by Scott Prahl (http://omlc.ogi.edu)";
char t2[] = "1 W Point Source Heating in Infinite Isotropic Scattering Medium";
char t3[] = "CPU version, adapted for PEAGPGPU by Gustavo Castellano"
            " and Nicolas Wolovick";

/***
 * Main matter
 ***/

int main(void)
{
    // heading
    printf("# %s\n# %s\n# %s\n", t1, t2, t3);
    printf("# Scattering = %8.3f/cm\n", MU_S);
    printf("# Absorption = %8.3f/cm\n", MU_A);
    printf("# Photons    = %8d\n#\n", PHOTONS);

    // Allocate host memory
    int n_photons = PHOTONS;  
    float* h_heat = (float*)malloc(n_photons * SHELLS * sizeof(float));
    float* h_heat2 = (float*)malloc(n_photons* SHELLS * sizeof(float));
    
    // Initialize host arrays
    for (int i = 0; i < SHELLS; i++) {
        h_heat[i] = 0.0f;
        h_heat2[i] = 0.0f;
    }

    // Allocate device memory/
    float* d_heat;
    float* d_heat2;
    
    curandState* d_states;
    cudaMalloc(&d_states, n_photons * sizeof(curandState));

    size_t total_size = (size_t)n_photons * SHELLS * sizeof(float);
    cudaMalloc(&d_heat,  total_size);
    cudaMalloc(&d_heat2, total_size);
	 
    cudaMemset(d_heat,  0, total_size);
    cudaMemset(d_heat2, 0, total_size);	

    // Initialize device constants
    init_device_constants();

    // start timer
    double start = wtime();

    // Launch simulation
    // Calculate grid and block dimensions
    int threadsPerBlock = 256;
    int blocksPerGrid = (n_photons + threadsPerBlock - 1) / threadsPerBlock;
    
    // Initialize random number generator states
    init_rng_kernel<<<blocksPerGrid, threadsPerBlock>>>(d_states, SEED);
    
    // Check for errors
    cudaError_t init_error = cudaGetLastError();
    if (init_error != cudaSuccess) {
        printf("CUDA error during initialization: %s\n", cudaGetErrorString(init_error));
        exit(1);
    }

    // If succes, Launch kernel
    unsigned long long seed = SEED;
    photon_kernel<<<blocksPerGrid, threadsPerBlock>>>(d_heat, d_heat2, d_states);
    
    // Check for errors
    cudaError_t error = cudaGetLastError();
    if (error != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(error));
        exit(1);
    }
    
    // Wait for kernel to finish
    cudaDeviceSynchronize();

    // stop timer
    double end = wtime();
    assert(start <= end);
    double elapsed = end - start;

    // Copy results back to host
    cudaMemcpy(h_heat,  d_heat, total_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(h_heat2, d_heat2, total_size,cudaMemcpyDeviceToHost);
    
    //Reducction of the sum
	/* float* h_heat_final  = (float*)malloc(SHELLS * sizeof(float));
	float* h2_heat_final = (float*)malloc(SHELLS * sizeof(float));
	for (int s = 0; s < SHELLS; ++s) {
    		double sum1 = 0, sum2 = 0;
    		for (int t = 0; t < n_photons; ++t) {
        		size_t idx = (size_t)t * SHELLS + s;
        		sum1 += h_heat[idx];
        		sum2 += h_heat2[idx];
    		}
    	h_heat_final[s]  = (float)sum1;
    	h2_heat_final[s] = (float)sum2;
	} */
   
     
    printf("# %lf seconds\n", elapsed);
    printf("# %lf K photons per second\n", 1e-3 * PHOTONS / elapsed);

    printf("# Radius\tHeat\n");
    printf("# [microns]\t[W/cm^3]\tError\n");
    /*
    float t = 4.0f * M_PI * powf(MICRONS_PER_SHELL, 3.0f) * PHOTONS / 1e12;
    for (unsigned int i = 0; i < SHELLS - 1; ++i) {
        printf("%6.0f\t%12.5f\t%12.5f\n", i * (float)MICRONS_PER_SHELL,
               h_heat[i] / t / (i * i + i + 1.0 / 3.0),
               sqrt(h_heat2[i] - h_heat[i] * h_heat[i] / PHOTONS) / t / (i * i + i + 1.0f / 3.0f));
    }
    */
    printf("# extra\t%12.5f\n", h_heat[SHELLS - 1] / PHOTONS);

    // Free memory
    free(h_heat);
    free(h_heat2);
    /* free(h_heat_final);
    free(h2_heat_final); */
    cudaFree(d_heat);
    cudaFree(d_heat2);
    return 0;
}
