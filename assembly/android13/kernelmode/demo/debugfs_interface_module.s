/*
 * debugfs_interface_module.s - Debugfs Interface Module Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates exposing internal state via debugfs.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_debugfs
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_debugfs_cleanup
    bl printk
    ret
.section .rodata
msg_debugfs:
    .asciz "Kernel Module: Debugfs Interface Activated\n"
msg_debugfs_cleanup:
    .asciz "Kernel Module: Debugfs Interface Deactivated\n"
