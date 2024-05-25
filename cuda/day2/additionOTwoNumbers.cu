#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

//cuda kernel to add two integers
__global__ void addIntegers(int *a, int *b, int *device_result)
{
        *device_result = *a + *b;
}

int main()
{
        //host variables
        int host_a = 5;
        int host_b = 5;
        int host_result = 0;

        //device variables
        int *device_a, *device_b, *device_result;

        //allocate memory on the device
        cudaMalloc((void**)&device_a, sizeof(int));
        cudaMalloc((void**)&device_b, sizeof(int));
        cudaMalloc((void**)&device_result, sizeof(int));

        //copy data from host to device
        cudaMemcpy(device_a, &host_a, sizeof(int), cudaMemcpyHostToDevice);
        cudaMemcpy(device_b, &host_b, sizeof(int), cudaMemcpyHostToDevice);

        //launch the kernel with
        addIntegers<<<1,1>>>(device_a, device_b, device_result);

        //copy result from device to host
        cudaMemcpy(&host_result, device_result, sizeof(int), cudaMemcpyDeviceToHost);

        printf("Result: %d\n", host_result);

        //free memory on the device
        cudaFree(device_a);
        cudaFree(device_b);
        cudaFree(device_result);

        return 0;

}

