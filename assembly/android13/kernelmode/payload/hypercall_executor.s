/*
 * hypercall_executor.s - Hypercall Executor Payload.
 *
 * Category: Kernel Mode Payload
 *
 * This module invokes a hypercall to communicate with the hypervisor.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_hypercall_activated
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_hypercall_deactivated
    bl printk
    ret
.section .rodata
msg_hypercall_activated:
    .asciz "Kernel Payload: Hypercall Executor Activated\n"
msg_hypercall_deactivated:
    .asciz "Kernel Payload: Hypercall Executor Deactivated\n"
