/*
 * kernel_log_dumper.s - Kernel Log Dumper Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates dumping the kernel log by printing a message.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_log
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ret
.section .rodata
msg_log:
    .asciz "Kernel Module: Kernel Log Dumper Demo\n"
