/*
 * kernel_bootstrap_loader.s - Kernel Bootstrap Loader
 *
 * This module simulates loading a payload during early boot (for demonstration, executed during module insertion).
 * It logs a message indicating that the bootstrap payload has been loaded.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =kboot_msg
    bl printk
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kboot_msg_exit
    bl printk
    ret
.section .rodata
kboot_msg:
    .asciz "Kernel Bootstrap Loader: payload loaded during boot\n"
kboot_msg_exit:
    .asciz "Kernel Bootstrap Loader deactivated\n"
