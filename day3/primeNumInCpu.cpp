#include <stdio.h>
#include <omp.h>
#include <chrono>
using namespace std;

int isprime(int num)
{
    if (num <= 1)
    {
        return 0;
    }
    for (int i = 2; i * i <= num; i++)
    {
        if (num % i == 0)
        {
            return 0;
        }
    }
    return 1;
}

int main()
{
    int num, count = 0;

    printf("Until which number you want prime numbers: ");
    scanf("%d", &num);
    auto start = chrono::high_resolution_clock::now();
    for (int i = 2; i <= num; i++)
    {
        if (isprime(i))
        {
            printf("%d\t", i);
            count++;
        }
    }
    auto end = chrono::high_resolution_clock::now();
    auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
    printf("\nTotal number of prime numbers up to %d: %d\n", num, count);
    printf("Time taken: %ld microseconds\n", duration.count());

    return 0;
}