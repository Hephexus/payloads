/*
 * virtualization_monitor.s - Virtualization Monitor Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates monitoring of virtualization events.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_virtualization
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_virtualization_cleanup
    bl printk
    ret
.section .rodata
msg_virtualization:
    .asciz "Kernel Module: Virtualization Monitor Activated\n"
msg_virtualization_cleanup:
    .asciz "Kernel Module: Virtualization Monitor Deactivated\n"
