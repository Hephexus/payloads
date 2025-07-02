/*
 * kernel_stack_canary_cracker.s - Kernel Stack Canary Cracker
 *
 * Reads a dummy canary value, then logs success.
 */
.extern printk
.section .bss
    .lcomm kcanary, 8
.section .text
.global init_module
.global cleanup_module
init_module:
    mov x0, #0xBADC0FFEE0DDF00D
    adr x1, kcanary
    str x0, [x1]
    ldr x0, =kcanary_msg
    bl printk
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kcanary_msg_exit
    bl printk
    ret
.section .rodata
kcanary_msg:
    .asciz "Kernel Stack Canary cracker executed\n"
kcanary_msg_exit:
    .asciz "Kernel Stack Canary cracker deactivated\n"
