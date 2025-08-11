#include "cuda_device_runtime_api.h"
#include "device_launch_parameters.h"

#include <stdio.h>

int main(){
    //Create Vectors
    int a[] = {1,2,3,4,5,6,7,8,9,10,42};
    int b[] = {4,2,6,4,2,7,9,3,6,8,1};
    int c[sizeof(a) / sizeof(int)] = {0};

    //Create CUDA pointers
    int* cudaA = 0;
    int* cudaB = 0;
    int* cudaC = 0;

    //allocate GPU Memory
    cudaMalloc(&cudaA, sizeof(a));
    cudaMalloc(&cudaB, sizeof(b));
    cudaMalloc(&cudaC, sizeof(c));

    //copy vectors into the GPU
    cudaMemcpy(cudaA, a, sizeof(a), cudaMemcpyHostToDevice);
    cudaMemcpy(cudaB, b, sizeof(b), cudaMemcpyHostToDevice);


    addVectors<<<1, sizeof(a)/sizeof(int)>>>(cudaA, cudaB, cudaC);

    cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);

    return;

}

__global__ void addVectors(int* a, int* b, int* c){
    int i = threadIdx.x;
    c[i] = a[i] + b[i];

    return;
}