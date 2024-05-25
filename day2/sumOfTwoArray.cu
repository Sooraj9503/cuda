#include<cuda.h>
#include<stdio.h>
#include<math.h>

__global__ void add_arrays(int *c, const int *a, const int *b, int size)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    if(i < size)
    {
        c[i] = a[i] + b[i];
    }
}

int main()
{
    const int size = 5;
    int a[size] = {1, 2, 3, 4, 5};
    int b[size] = {1, 2, 3, 4, 5};
    int c[size];

    int *d_a, *d_b, *d_c;

    //Allocate memory on the device for arrays a, b, and c
    cudaMalloc((void**)&d_a, size * sizeof(int));
    cudaMalloc((void**)&d_b, size * sizeof(int));
    cudaMalloc((void**)&d_c, size * sizeof(int));

    //Copy arrays a and b to the device
    cudaMemcpy(d_a, a, size * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size * sizeof(int), cudaMemcpyHostToDevice);

    //Launch the kernel on the GPU
    add_arrays<<<1, size>>>(d_c, d_a, d_b, size);

    //Copy the result back to the host
    cudaMemcpy(c, d_c, size * sizeof(int), cudaMemcpyDeviceToHost);

    //Print the result
    for(int i = 0; i < size; i++)
    {
        printf("%d ", c[i]);
    }
    printf("\n");

    //Free the memory allocated on the device
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}