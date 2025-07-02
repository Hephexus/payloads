/*
 * hardware_watchdog_controller.s - Hardware Watchdog Controller Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates controlling a hardware watchdog timer.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_watchdog
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_watchdog_cleanup
    bl printk
    ret
.section .rodata
msg_watchdog:
    .asciz "Kernel Module: Watchdog Controller Activated\n"
msg_watchdog_cleanup:
    .asciz "Kernel Module: Watchdog Controller Deactivated\n"
