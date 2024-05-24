#include<cuda_runtime.h>
#include<device_launch_parameters.h>
#include<stdio.h>

int main()
{
    const int arraySize = 5;

    //host (cpu) data
    float hostArray[arraySize] = {1.0, 2.0, 3.0, 4.0, 5.0};
    float hostResult[arraySize];

    //Device (gpu) data
    float* deviceArray;
    cudaMalloc((void**)&deviceArray, arraySize * sizeof(float));

    //copy data from cpu to gpu
    cudaMemcpy(deviceArray, hostArray, arraySize * sizeof(float), cudaMemcpyHostToDevice);

    //copy data from gpu to cpu
    cudaMemcpy(hostResult, deviceArray, arraySize * sizeof(float), cudaMemcpyDeviceToHost);

    //Display results using printf
    printf("Original array: ");
    for(int i = 0; i < arraySize; ++i)
    {
        printf("%f ", hostArray[i]);
    }
    printf("\n");
    printf("Copied array: ");
    for(int i = 0; i < arraySize; ++i)
    {
        printf("%f ", hostResult[i]);
    }
    printf("\n");

    //free allocated memory on gpu
    cudaFree(deviceArray);
    return 0;
}
