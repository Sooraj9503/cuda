#include<stdio.h>
#include<stdlib.h>

int main()
{
    int *arr1, *arr2, *result;
    int ROWS = 4;
    int COLS = 6;
    int i, j;

    //dynamically memory allocation
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

    //Addition of both arrays
    for (i = 0; i < ROWS; i++) 
    {
        for (j = 0; j < COLS; j++) 
        {
            result[i * COLS + j] = arr1[i * COLS + j] + arr2[i * COLS + j];
        }
    }

    printf("\n");
    printf("Array 1:\n");
    for(i = 0; i < ROWS; i++)
    {
        for(j = 0; j < COLS; j++)
        {
            printf("%3d ", arr1[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    printf("Array 2:\n");
    for(i = 0; i < ROWS; i++)
    {
        for(j = 0; j < COLS; j++)
        {
            printf("%3d ", arr2[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    printf("Addition of both arrays:\n");
    for(i = 0; i < ROWS; i++)
    {
        for(j = 0; j < COLS; j++)
        {
            printf("%3d ", result[i][j]);
        }
        printf("\n");
    }

    //free the memory in cpu

    //free all indices
    for(i = 0; i < ROWS; i++)
    {
        free(arr1[i]);
        free(arr2[i]);
        free(result[i]);
    }

    //free array
    free(arr1);
    free(arr2);
    free(result);

    return 0;
}