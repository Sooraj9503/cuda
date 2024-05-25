#include<stdio.h>
#include<stdlib.h>

int main()
{
    int *arr1, *arr2, *result;
    int ROWS = 4;
    int COLS = 6;
    int i, j;

    //Allocate memory dynamically

    arr1 = (int*)malloc(ROWS * COLS * sizeof(int));
    arr2 = (int*)malloc(ROWS * COLS * sizeof(int));
    result = (int*)malloc(ROWS * COLS * sizeof(int));

    //Initialize arrays
    for (i = 0; i < ROWS; i++) 
    {
        for (j = 0; j < COLS; j++) 
        {
            arr1[i * COLS + j] = i * COLS + j + 1;
            arr2[i * COLS + j] = i * COLS + j + 1 + ROWS * COLS;
        }
    }

    //Display arrays
    printf("\nArray 1:\n");
    for(i = 0; i < ROWS; i++)
    {
        for(j = 0; j < COLS; j++)
        {
            printf("%3d ", arr1[i * COLS + j]);
        }
        printf("\n");
    }
    printf("\nArray 2:\n");
    for(i = 0; i < ROWS; i++)
    {
        for(j = 0; j < COLS; j++)
        {
            printf("%3d ", arr2[i * COLS +j]);
        }
        printf("\n");
    }

    //Free the memory
    free(arr1);
    free(arr2);

    return 0;
}