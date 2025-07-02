/*
 * kernel_system_statistics_reporter.s - Kernel System Statistics Reporter Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates aggregation and reporting of system statistics.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_sysstats
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_sysstats_cleanup
    bl printk
    ret
.section .rodata
msg_sysstats:
    .asciz "Kernel Module: System Statistics Reporter Activated\n"
msg_sysstats_cleanup:
    .asciz "Kernel Module: System Statistics Reporter Deactivated\n"
