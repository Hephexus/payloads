/*
 * direct_hw_register_access.s - Direct Hardware Register Access Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module demonstrates (conceptually) direct hardware register access.
 * In a real scenario you would read from or write to actual hardware registers.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_dhw
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ret
.section .rodata
msg_dhw:
    .asciz "Kernel Module: Direct Hardware Register Access Demo\n"
