/*
 * kernel_module_code_injector.s - Kernel Module Code Injector Payload.
 *
 * Category: Kernel Mode Payload
 *
 * This module simulates injecting code into another kernel module.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_injector_activated
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_injector_deactivated
    bl printk
    ret
.section .rodata
msg_injector_activated:
    .asciz "Kernel Payload: Module Code Injector Activated\n"
msg_injector_deactivated:
    .asciz "Kernel Payload: Module Code Injector Deactivated\n"
