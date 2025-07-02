/*
 * kernel_benchmark_suite.s - Kernel Benchmark Suite Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates benchmarking various kernel operations.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_benchmark
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_benchmark_cleanup
    bl printk
    ret
.section .rodata
msg_benchmark:
    .asciz "Kernel Module: Benchmark Suite Activated\n"
msg_benchmark_cleanup:
    .asciz "Kernel Module: Benchmark Suite Deactivated\n"
