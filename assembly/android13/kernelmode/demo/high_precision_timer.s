/*
 * high_precision_timer.s - High Precision Timer Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module conceptually demonstrates a high-precision timer by logging a message.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_timer
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ret
.section .rodata
msg_timer:
    .asciz "Kernel Module: High Precision Timer Demo\n"
