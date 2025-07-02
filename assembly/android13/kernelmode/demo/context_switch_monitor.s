/*
 * context_switch_monitor.s - Context Switch Monitor Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates monitoring process context switches.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_context
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_context_cleanup
    bl printk
    ret
.section .rodata
msg_context:
    .asciz "Kernel Module: Context Switch Monitor Activated\n"
msg_context_cleanup:
    .asciz "Kernel Module: Context Switch Monitor Deactivated\n"
