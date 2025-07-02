/*
 * module_autoreload.s - Module Autoreload
 *
 * This module simulates auto-reloading behavior in a kernel module.
 * In a real system, a mechanism (such as a kernel watchdog) might re-insert the module if unloaded.
 * Here, we simply log a heartbeat message in a loop.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    mov w0, #0
autoreload_loop:
    ldr x0, =kauto_msg
    bl printk
    mov w1, #50000
delay_loop:
    subs w1, w1, #1
    bne delay_loop
    add w0, w0, #1
    cmp w0, #3
    blt autoreload_loop
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kauto_msg_exit
    bl printk
    ret
.section .rodata
kauto_msg:
    .asciz "Module Autoreload: module still active\n"
kauto_msg_exit:
    .asciz "Module Autoreload deactivated\n"
