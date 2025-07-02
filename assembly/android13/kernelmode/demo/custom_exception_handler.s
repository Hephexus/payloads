/*
 * custom_exception_handler.s - Custom Exception Handler Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates installing a custom exception handler.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_exception
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_exception_cleanup
    bl printk
    ret
.section .rodata
msg_exception:
    .asciz "Kernel Module: Custom Exception Handler Activated\n"
msg_exception_cleanup:
    .asciz "Kernel Module: Custom Exception Handler Deactivated\n"
