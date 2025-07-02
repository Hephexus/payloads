/*
 * slab_allocator_inspector.s - Slab Allocator Inspector Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module inspects and reports on the slab allocator status.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_slab
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_slab_cleanup
    bl printk
    ret
.section .rodata
msg_slab:
    .asciz "Kernel Module: Slab Allocator Inspector Activated\n"
msg_slab_cleanup:
    .asciz "Kernel Module: Slab Allocator Inspector Deactivated\n"
