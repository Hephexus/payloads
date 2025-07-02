/*
 * device_driver_stub.s - Device Driver Stub Demo.
 *
 * Category: Kernel Mode Demo
 *
 * A minimal stub for a device driver that logs its loading.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_driver
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ret
.section .rodata
msg_driver:
    .asciz "Kernel Module: Device Driver Stub Loaded\n"
