/*
 * stack_trace_dumper.s - Stack Trace Dumper Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates capturing and dumping a stack trace.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_stack_trace
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_stack_trace_cleanup
    bl printk
    ret
.section .rodata
msg_stack_trace:
    .asciz "Kernel Module: Stack Trace Dumper Activated\n"
msg_stack_trace_cleanup:
    .asciz "Kernel Module: Stack Trace Dumper Deactivated\n"
