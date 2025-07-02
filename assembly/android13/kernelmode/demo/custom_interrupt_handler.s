/*
 * custom_interrupt_handler.s - Custom Interrupt Handler Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module conceptually demonstrates installing a custom interrupt handler.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_interrupt
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ret
.section .rodata
msg_interrupt:
    .asciz "Kernel Module: Custom Interrupt Handler Demo\n"
