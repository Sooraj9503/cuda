#include <stdio.h>
#define ROWS 4
#define COLS 6

 //Kernel function for addition
    __global__ void add(int *dev_arr1, int *dev_arr2, int *dev_result)
    {
        int idx = blockIdx.x * blockDim.x + threadIdx.x;
        if(idx < ROWS * COLS)
        {
            dev_result[idx] = dev_arr1[idx] + dev_arr2[idx];
        }
    }

int main() {
    int *arr1, *arr2, *result;
    int *dev_arr1, *dev_arr2, *dev_result;
    int i, j;

    // Allocate memory on host
    arr1 = (int *)malloc(ROWS * COLS * sizeof(int));
    arr2 = (int *)malloc(ROWS * COLS * sizeof(int));
    result = (int *)malloc(ROWS * COLS * sizeof(int));

    // Initialize arrays
    for (i = 0; i < ROWS; i++) 
    {
        for (j = 0; j < COLS; j++) 
        {
            arr1[i * COLS + j] = i * COLS + j + 1;
            arr2[i * COLS + j] = i * COLS + j + 1 + ROWS * COLS;
        }
    }

    //Allocate memory on gpu
    cudaMalloc((void **)&dev_arr1, ROWS * COLS * sizeof(int));
    cudaMalloc((void **)&dev_arr2, ROWS * COLS * sizeof(int));
    cudaMalloc((void **)&dev_result, ROWS * COLS * sizeof(int));

    //Copy data from host to device
    cudaMemcpy( dev_arr1, arr1, ROWS * COLS * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy( dev_arr2, arr2, ROWS * COLS * sizeof(int), cudaMemcpyHostToDevice);

    //Kernel function call
    int threads = 256;
    int blocks = (ROWS * COLS + threads - 1) / threads;

    add<<<blocks, threads>>>(dev_arr1, dev_arr2, dev_result);

    //Copy data from device to host
    cudaMemcpy(result, dev_result, ROWS * COLS * sizeof(int), cudaMemcpyDeviceToHost);

    //Display 1st array
    printf("\nArray 1:\n");
    for (i = 0; i < ROWS; i++)
    {
        for (j = 0; j < COLS; j++)
        {
            printf("%3d ", arr1[i * COLS + j]);
        }
        printf("\n");
    }

    //Display 2nd array
    printf("\nArray 2:\n");
    for (i = 0; i < ROWS; i++)
    {
        for (j = 0; j < COLS; j++)
        {
            printf("%3d ", arr2[i * COLS + j]);
        }
        printf("\n");
    }

    // Print result
    printf("\nResult:\n");
    for (i = 0; i < ROWS; i++) {
        for (j = 0; j < COLS; j++) {
            printf("%3d ", result[i * COLS + j]);
        }
        printf("\n");
    }

    // Free memory
    free(arr1);
    free(arr2);
    free(result);
    cudaFree(dev_arr1);
    cudaFree(dev_arr2);
    cudaFree(dev_result);
    
    return 0;
}