#include<stdio.h>
#include<cuda.h>

__device__ int square(int a)
{
    printf("Tread (%d, %d) - squaring value\n", blockIdx.x, threadIdx.x);
    return a * a;
}

__global__ void doubleValues(int* data, int size)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if(i < size)
    {
        int value = data[i];
        
        //call square function and print thread ID
        int squared_value = square(value);
        printf("Thread (%d, %d) - squared value: %d\n", blockIdx.x, threadIdx.x, squared_value);
        data[i] = squared_value * 2;
    }
}

int main()
{
    //Allocate memory on host
    int size = 10;
    int* host_data = new int[size];
    int* dev_data;
    cudaMalloc((void **)&dev_data, size * sizeof(int));

    //Initialize data on host
    for(int i = 0; i < size; i++)
    {
        host_data[i] = i;
    }

    //Copy data from host to device
    cudaMemcpy(dev_data, host_data, size * sizeof(int), cudaMemcpyHostToDevice);

    //Launch kernel function
    int threads = 256;
    int blocks = (size + threads -1) / threads;
    doubleValues<<<blocks, threads>>>(dev_data, size);

    //Wait for kernel to finish
    cudaDeviceSynchronize();

    //Copy data from device to host
    cudaMemcpy(host_data, dev_data, size * sizeof(int), cudaMemcpyDeviceToHost);

    //Print result
    for(int i = 0; i < size; i++)
    {
        printf("Result: %d\n", host_data[i]);
    }

    //Free memory
    cudaFree(dev_data);
    delete[] host_data;
    return 0;
}