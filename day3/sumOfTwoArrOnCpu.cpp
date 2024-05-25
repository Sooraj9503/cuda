#include <iostream>
#include <math.h>
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
    for (int i = 0; i < size; i++)
    {
        c[i] = a[i] + b[i];
    }
    for (int i = 0; i < size; i++)
    {
        printf("%d\t", c[i]);
    }
    printf("\n");

    return 0;
}
