#include <iostream>
#include <chrono>
#define size 1000000;
using namespace std;

__global__ void prime(int *num, int *p)
{
    int a = 1;
    for (int i = 2; i < num - 1; i++)
    {
        if (num % i == 0)
        {
            a = 0;
            break;
        }
    }
    if (a == 1)
        p[size]= num;
}

int main()
{
    int num = 0;
    cout << "Enter until which number you want prime numbers: " << endl;
    cin >> num;
    //host variables
    int num, p[size];
    //device variables
    int *d_num, *d_p;

    //allocate memory in gpu
    cudaMemcpy((void**)&d_num,sizeof(int))
    cudaMemcpy((void**)&d_p, size * sizeof(int))

    //copy host to device[gpu]
    cudaMemcpy(d_num, num, sizeof(int), cudaMemcpyHostToDevice)
    cudaMemcpy(p_num, p, size * sizeof(int), cudaMemcpyHostToDevice)

    prime<<<1,size>>>(d_num,d_p,size);

    //copy device to host
    cudaMemcpy(p, num, size * sizeof(int), cudaMemcpyDeviceToHost)

    for (int i = 2; i <size; i++)
        cout<<i<<endl;
    
    cudaFree(d_num);
    cudaFree(d_p);
    return 0;
}