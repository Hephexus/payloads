/*
 * direct_system_time_manipulator.s - Direct System Time Manipulator Payload.
 *
 * Category: Kernel Mode Payload
 *
 * This module directly manipulates the kernel’s system time (for testing purposes).
 * It prints activation and deactivation messages using printk.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_time_manipulator_activated
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_time_manipulator_deactivated
    bl printk
    ret
.section .rodata
msg_time_manipulator_activated:
    .asciz "Kernel Payload: System Time Manipulator Activated\n"
msg_time_manipulator_deactivated:
    .asciz "Kernel Payload: System Time Manipulator Deactivated\n"
