#include<stdio.h>
#include<stdlib.h>
#include<chrono>
#define n 5

int** allocate_matrix(int rows, int cols) {
    int** matrix = (int**)malloc(rows * sizeof(int*));
    for(int i = 0; i < rows; i++) {
        matrix[i] = (int*)malloc(cols * sizeof(int));
    }
    return matrix;
}

void initialize_matrix(int** matrix, int rows, int cols) {
    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 10;
        }
    }
}

void print_matrix(int** matrix, int rows, int cols) {
    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

void matrix_multiply(int** A, int** B, int** C) {
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            C[i][j] = 0;
            for(int k = 0; k < n; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

int main() {
    int** A = allocate_matrix(n, n);
    int** B = allocate_matrix(n, n);
    int** C = allocate_matrix(n, n);

    initialize_matrix(A, n, n);
    initialize_matrix(B, n, n);

    auto cpu_start_time = std::chrono::high_resolution_clock::now();
    matrix_multiply(A, B, C);
    auto cpu_end_time = std::chrono::high_resolution_clock::now();

    auto cpu_duration_ns = std::chrono::duration_cast<std::chrono::nanoseconds>(cpu_end_time - cpu_start_time).count();
    
    // print matrices A, B, and C
    printf("Matrix A:\n");
    print_matrix(A, n, n);
    printf("Matrix B:\n");
    print_matrix(B, n, n);
    printf("\nMatrix C(Result of A*B):\n");
    print_matrix(C, n, n);
    printf("Time taken by CPU: %f microseconds\n", (float)cpu_duration_ns / 1000);

    for(int i = 0; i < n; i++)
    {
        free(A[i]);
        free(B[i]);
        free(C[i]);
    }
    free(A);
    free(B);
    free(C);
    return 0;
}