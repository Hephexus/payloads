/*
 * self_unloading_module.s - Self-Unloading Module Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module demonstrates self-unloading capabilities.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_self_unload
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_self_unload_cleanup
    bl printk
    ret
.section .rodata
msg_self_unload:
    .asciz "Kernel Module: Self-Unloading Module Activated\n"
msg_self_unload_cleanup:
    .asciz "Kernel Module: Self-Unloading Module Deactivated\n"
