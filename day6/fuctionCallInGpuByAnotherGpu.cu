#include<stdio.h>
#include<cuda.h>

__global__ void child()
{
    printf(" World\n");
}

__global__ void parent()
{
    printf("Hello ");
    child<<<1,1>>>();
}

int main()
{    
    parent<<<1,1>>>();
    cudaDeviceSynchronize();

    return 0;
}