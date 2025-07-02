/*
 * syscall_logger.s - Syscall Logger Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates logging of system call invocations.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_syscall_logger
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_syscall_logger_cleanup
    bl printk
    ret
.section .rodata
msg_syscall_logger:
    .asciz "Kernel Module: Syscall Logger Activated\n"
msg_syscall_logger_cleanup:
    .asciz "Kernel Module: Syscall Logger Deactivated\n"
