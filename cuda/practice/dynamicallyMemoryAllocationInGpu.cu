#include <stdio.h>

#define ROWS 4
#define COLS 6



int main() {
    int *arr1, *arr2, *result;
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
    //Addition of both arrays
    for (i = 0; i < ROWS; i++) 
    {
        for (j = 0; j < COLS; j++) 
        {
            result[i * COLS + j] = arr1[i * COLS + j] + arr2[i * COLS + j];
        }
    }

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

    return 0;
}