/*
 * kernel_hello_world.s - Kernel Mode Hello World Module.
 *
 * Category: Kernel Mode Demo
 *
 * A minimal kernel module that prints a hello message to the kernel log.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    // Print a hello message.
    ldr x0, =msg_hello
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ret
.section .rodata
msg_hello:
    .asciz "Kernel Module: Hello World from kernel mode!\n"
