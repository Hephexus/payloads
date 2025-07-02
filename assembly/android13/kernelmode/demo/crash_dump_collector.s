/*
 * crash_dump_collector.s - Crash Dump Collector Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates collecting a crash dump.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_crash_dump
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_crash_dump_cleanup
    bl printk
    ret
.section .rodata
msg_crash_dump:
    .asciz "Kernel Module: Crash Dump Collected\n"
msg_crash_dump_cleanup:
    .asciz "Kernel Module: Crash Dump Collector Deactivated\n"
