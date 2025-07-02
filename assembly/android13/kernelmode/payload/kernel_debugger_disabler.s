/*
 * kernel_debugger_disabler.s - Kernel Debugger Disabler Payload.
 *
 * Category: Kernel Mode Payload
 *
 * This module disables the kernel debugger interface to hide its activity.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_debugger_disabler_activated
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_debugger_disabler_deactivated
    bl printk
    ret
.section .rodata
msg_debugger_disabler_activated:
    .asciz "Kernel Payload: Debugger Disabler Activated\n"
msg_debugger_disabler_deactivated:
    .asciz "Kernel Payload: Debugger Disabler Deactivated\n"
