#include <iostream>
#include <math.h>
#include <chrono>
#define size 90000
using namespace std;
int main()
{
    int a[size];
    int b[size];
    int c[size];

    for (int i = 0; i < size; i++)
    {
        a[i] = rand() % 90000;
        b[i] = rand() % 90000;
    }
    auto start = chrono::high_resolution_clock::now();
    for (int i = 0; i < size; i++)
    {
        c[i] = a[i] + b[i];
    }
    auto end = chrono::high_resolution_clock::now();
    for (int i = 0; i < 10; i++)
    {
        printf("%d\t", c[i]);
    }
    printf("\n");
    auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
    cout << "Time taken by function: " << duration.count() << " microseconds" << endl;
    
    return 0;
}
