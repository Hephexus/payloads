/*
 * kernel_interrupt_latency_tester.s - Kernel Interrupt Latency Tester Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates measuring interrupt latency.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_latency
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_latency_cleanup
    bl printk
    ret
.section .rodata
msg_latency:
    .asciz "Kernel Module: Interrupt Latency Tester Activated\n"
msg_latency_cleanup:
    .asciz "Kernel Module: Interrupt Latency Tester Deactivated\n"
