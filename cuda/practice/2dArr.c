#include<stdio.h>
#define rows 4
#define cols 6

void add(int arr1[rows][cols], int arr2[rows][cols], int arr3[rows][cols])
{
    for(int i = 0; i < rows; i++)
    {
        for(int j = 0; j < cols; j++)
        {
            arr3[i][j] = arr1[i][j] + arr2[i][j];
        }
    }
}
int main()
{
    //Declare array

    int arr1[rows][cols];
    int arr2[rows][cols];
    int arr3[rows][cols];

    //Initialization of array

    for(int i = 0; i < rows; i++)
    {
        for(int j = 0; j < cols; j++)
        {
            arr1[i][j] = i * cols + j;
            arr2[i][j] = i * cols + j;
        }
    }



    //Display array
    printf("\nPrinting 1st array:\n");
    for(int i = 0; i < rows; i++)
    {
        for(int j = 0; j < cols; j++)
        {
            printf("%3d ", arr1[i][j]);
        }
        printf("\n");
    }

    printf("\nPrinting 2nd array:\n");
    for(int i = 0; i < rows; i++)
    {
        for(int j = 0; j < cols; j++)
        {
            printf("%3d ", arr2[i][j]);
        }
        printf("\n");
    }
    
    printf("\nAddition:\n");
    add(arr1,arr2,arr3);
    for(int i = 0; i < rows; i++)
    {
        for(int j = 0; j < cols; j++)
        {
            printf("%3d ", arr3[i][j]);
        }
        printf("\n");
    }

    return 0;
}