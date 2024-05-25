#include<stdio.h>
#include<cuda_runtime.h>

#define N 5

__global__ void add(int *a, int *b, int *c) 
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    int j = blockIdx.y * blockDim.y + threadIdx.y;
    if (i < N && j < N)
    {
    c[i*N+j] = a[i*N+j] + b[i*N+j];
    }
}

int main() 
{
    int *a, *b, *c;
    int *d_a, *d_b, *d_c;

    // Allocate space for arrays a, b, and c
    a = (int *)malloc(N * N * sizeof(int));
    b = (int *)malloc(N * N * sizeof(int));
    c = (int *)malloc(N * N * sizeof(int));

    // Allocate memory on the GPU
    cudaMalloc((void **)&d_a, N * N * sizeof(int));
    cudaMalloc((void **)&d_b, N * N * sizeof(int));
    cudaMalloc((void **)&d_c, N * N * sizeof(int));

    // Initialize arrays a and b
    for (int i = 0; i < N; i++) 
    {
        for (int j = 0; j < N; j++) 
        {
                a[i*N+j] = 1;
                b[i*N+j] = 1;
        }
    }
     for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) 
        {
                printf("%d ", c[i*N+j]);
        }
        printf("\n");
    }

    // Copy arrays a and b to the GPU
    cudaMemcpy(d_a, a, N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, N * N * sizeof(int), cudaMemcpyHostToDevice);

    // Launch the kernel on the GPU
    int threadsPerBlock = 5;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;
    add<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_b, d_c);

    // Copy the result back to the CPU
    cudaMemcpy(c, d_c, N * N * sizeof(int), cudaMemcpyDeviceToHost);

    // Print the result
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) 
        {
                printf("%d ", c[i*N+j]);
        }
        printf("\n");
    }

    // Free memory
    free(a);
    free(b);
    free(c);
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}