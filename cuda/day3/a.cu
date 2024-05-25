#include <cuda.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

// Set the number of threads per block to 256, which is a multiple of the
// number of CUDA cores per multiprocessor (32) and smaller than the maximum
// number of threads per block (1024).
#define THREADS_PER_BLOCK 256

// Set the number of blocks to 64, which is the maximum number of blocks that
// can be launched per multiprocessor. This value should be chosen based on
// the number of CUDA cores per multiprocessor and the number of multiprocessors
// on the GPU.
#define BLOCKS 64

__global__ void add_arrays(int *c, const int *a, const int *b, int size)
{
    // Calculate the index of the current thread
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    // Make sure that the index is within the bounds of the arrays
    if (i < size)
    {
        // Add the elements at the current index in the two input arrays    
        c[i] = a[i] + b[i];
    }
}

int main()
{
    const int size = 15000;
    int *a = (int*)malloc(size * sizeof(int));
    int *b = (int*)malloc(size * sizeof(int));
    int *c = (int*)malloc(size * sizeof(int));

    for(int i = 0; i < size; i++)
    {
        a[i] = rand() % 14999;
        b[i] = rand() % 14999;
    }

    int *d_a, *d_b, *d_c;

    // Allocate memory on the device for arrays a, b, and c
    cudaMalloc((void**)&d_a, size * sizeof(int));
    cudaMalloc((void**)&d_b, size * sizeof(int));
    cudaMalloc((void**)&d_c, size * sizeof(int));

    // Copy arrays a and b to the device
    cudaMemcpy(d_a, a, size * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size * sizeof(int), cudaMemcpyHostToDevice);

    // Launch the kernel on the GPU with the correct number of threads and blocks
    add_arrays<<<BLOCKS, THREADS_PER_BLOCK>>>(d_c, d_a, d_b, size);

    // Copy the result back to the host
    cudaMemcpy(c, d_c, size * sizeof(int), cudaMemcpyDeviceToHost);

    // Print the result
    for(int i = 0; i < size; i++)
    {
        printf("%d ", c[i]);
    }
    printf("\n");

    // Free the memory allocated on the device
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    // Free the memory allocated on the host
    free(a);
    free(b);
    free(c);

    return 0;
}