#include <iostream>
#include <math.h>
#include <chrono>
#define size 90000
#include <cuda_runtime.h>

using namespace std;

__global__ void add(int *a, int *b, int *c, int n) 
{
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index < n)
        c[index] = a[index] + b[index];
}

int main()
{
    int *a, *b, *c;
    int n = size;
    int *d_a, *d_b, *d_c;
    int blockSize = 256;
    int numBlocks = (n + blockSize - 1) / blockSize;

    a = new int[n];
    b = new int[n];
    c = new int[n];

    for (int i = 0; i < n; i++) {
        a[i] = rand() % 90000;
        b[i] = rand() % 90000;
    }

    cudaMallocManaged(&d_a, n * sizeof(int));
    cudaMallocManaged(&d_b, n * sizeof(int));
    cudaMallocManaged(&d_c, n * sizeof(int));

    cudaMemcpy(d_a, a, n * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, n * sizeof(int), cudaMemcpyHostToDevice);

    auto start = chrono::high_resolution_clock::now();
    add<<<numBlocks, blockSize>>>(d_a, d_b, d_c, n);
    cudaDeviceSynchronize();
    auto end = chrono::high_resolution_clock::now();

    cudaMemcpy(c, d_c, n * sizeof(int), cudaMemcpyDeviceToHost);

    for (int i = 0; i < 10; i++) {
        printf("%d\t", c[i]);
    }
    printf("\n");

    auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
    cout << "Time taken by GPU: " << duration.count() << " microseconds" << endl;

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    delete[] a;
    delete[] b;
    delete[] c;

    return 0;
}