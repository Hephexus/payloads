/*
 * kernel_logging_fuzzer.s - Kernel Logging Fuzzer.
 *
 * This module repeatedly calls printk with a fixed format string to simulate log flooding.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    mov w0, #0
log_loop:
    ldr x0, =klog_msg
    bl printk
    add w0, w0, #1
    cmp w0, #5
    blt log_loop
    ret
cleanup_module:
    ldr x0, =klog_msg_deactivated
    bl printk
    ret
.section .rodata
klog_msg:
    .asciz "Kernel Logging Fuzzer iteration executed\n"
klog_msg_deactivated:
    .asciz "Kernel Logging Fuzzer deactivated\n"
