/*
 * kernel_debug_helper.s - Kernel Debug Helper Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module acts as a kernel debug helper by printing a debug message.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_debug
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ret
.section .rodata
msg_debug:
    .asciz "Kernel Module: Kernel Debug Helper Demo\n"
