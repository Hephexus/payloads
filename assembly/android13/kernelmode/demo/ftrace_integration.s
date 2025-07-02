/*
 * ftrace_integration.s - Ftrace Integration Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates hooking into ftrace to monitor function calls.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_ftrace
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_ftrace_cleanup
    bl printk
    ret
.section .rodata
msg_ftrace:
    .asciz "Kernel Module: Ftrace Integration Activated\n"
msg_ftrace_cleanup:
    .asciz "Kernel Module: Ftrace Integration Deactivated\n"
