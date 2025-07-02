/*
 * memory_allocation_fuzzer.s - User-Mode Memory Allocation Fuzzer.
 *
 * This fuzzer iterates over allocation sizes from 0x1000 to 0x5000 bytes,
 * invoking mmap to allocate memory and immediately unmapping it.
 */
 
.section .text
.global main
main:
    mov w0, #0x1000    // 4096 bytes
alloc_loop:
    mov x0, 0          // addr = NULL
    mov x1, w0         // size = current iteration value
    mov x2, #3         // PROT_READ | PROT_WRITE
    mov x3, #0x22      // MAP_PRIVATE | MAP_ANONYMOUS
    mov x4, #-1
    mov x5, 0
    mov x8, #222       // mmap syscall
    svc 0
    mov x0, x0       // Get pointer from mmap result
    mov x1, w0       // Unmap the same size
    mov x8, #215     // munmap syscall
    svc 0
    add w0, w0, #0x1000
    cmp w0, #0x5000
    blt alloc_loop
    mov x0, #0
    mov x8, #93
    svc 0
