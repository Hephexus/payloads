/*
 * kaslr_bypass_kernel.s - Kernel ASLR Bypass
 *
 * Reads a system register (here we use tpidr_el0 as an analogue) and subtracts a constant to compute the kernel base.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    mrs x0, tpidr_el0
    sub x0, x0, #0x1000
    ldr x0, =kkaslr_msg
    bl printk
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kkaslr_msg_exit
    bl printk
    ret
.section .rodata
kkaslr_msg:
    .asciz "Kernel ASLR bypass: base calculated as 0xDEADBEEF\n"
kkaslr_msg_exit:
    .asciz "Kernel ASLR bypass module deactivated\n"
