/*
 * critical_section_instrumentation.s - Critical Section Instrumentation Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates instrumentation within critical sections of code.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_critical
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_critical_cleanup
    bl printk
    ret
.section .rodata
msg_critical:
    .asciz "Kernel Module: Critical Section Instrumentation Activated\n"
msg_critical_cleanup:
    .asciz "Kernel Module: Critical Section Instrumentation Deactivated\n"
