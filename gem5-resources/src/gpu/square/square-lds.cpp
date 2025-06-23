#include <stdio.h>
#include "hip/hip_runtime.h"
// #include "gem5/m5ops.h"
// #include <m5_mmap>

#define CHECK(cmd) \
{\
    hipError_t error  = cmd;\
    if (error != hipSuccess) { \
      fprintf(stderr, "error: '%s'(%d) at %s:%d\n", hipGetErrorString(error), error,__FILE__, __LINE__); \
    exit(EXIT_FAILURE);\
    }\
}

/*
 * Square each element in the array A and write to array C.
 * Shared memory is used to cache data before squaring.
 */
template <typename T>
__global__ void
vector_square_shared(T *C_d, const T *A_d, size_t N)
{
    extern __shared__ T shmem[];

    size_t tid = hipThreadIdx_x;
    size_t gid = hipBlockIdx_x * hipBlockDim_x + tid;
    size_t stride = hipBlockDim_x * hipGridDim_x;

    for (size_t i = gid; i < N; i += stride) {
        // Load from global to shared memory
        shmem[tid] = A_d[i];
        __syncthreads();

        // Square in shared memory then write to global
        T temp = shmem[tid];
        C_d[i] = temp * temp;
    }
}

int main(int argc, char *argv[])
{
    float *A_h, *C_h;
    float *A_d, *C_d;

    size_t N = 1000000;
    size_t Nbytes = N * sizeof(float);
    // m5op_addr = 0xFFFF0000;
    // map_m5_mem();

    hipDeviceProp_t props;
    CHECK(hipGetDeviceProperties(&props, 0));
    printf ("info: running on device %s\n", props.name);
    #ifdef __HIP_PLATFORM_HCC__
      printf ("info: architecture on AMD GPU device is: %d\n", props.gcnArch);
    #endif

    printf ("info: allocate host mem (%6.2f MB)\n", 2*Nbytes/1024.0/1024.0);
    A_h = (float*)malloc(Nbytes);
    C_h = (float*)malloc(Nbytes);

    // Init host data
    for (size_t i = 0; i < N; i++) {
        A_h[i] = 1.618f + i;
    }

    // Device malloc & memcpy to avoid system request
    CHECK(hipMalloc(&A_d, Nbytes));
    CHECK(hipMalloc(&C_d, Nbytes));
    CHECK(hipMemcpy(A_d, A_h, Nbytes, hipMemcpyHostToDevice));

    // m5_checkpoint_addr();
    const unsigned blocks = 512;
    const unsigned threadsPerBlock = 256;
    size_t shmem_size = threadsPerBlock * sizeof(float); // per block shared mem

    printf ("info: launch 'vector_square_shared' kernel\n");
    hipLaunchKernelGGL(vector_square_shared, dim3(blocks), dim3(threadsPerBlock), shmem_size, 0, C_d, A_d, N);
    CHECK(hipDeviceSynchronize());

    // Copy back results
    CHECK(hipMemcpy(C_h, C_d, Nbytes, hipMemcpyDeviceToHost));

    printf ("info: check result\n");
    for (size_t i = 0; i < N; i++) {
        if (C_h[i] != A_h[i] * A_h[i]) {
            CHECK(hipErrorUnknown);
        }
    }

    printf ("PASSED!\n");

    free(A_h);
    free(C_h);
    hipFree(A_d);
    hipFree(C_d);
    return 0;
}
