/*
 * cfi_evasion_kernel.s - Kernel CFI Evasion
 *
 * This module recalculates a dummy function pointer and then “jumps” to it.
 */
.extern printk
.section .data
kcfi_target:
    .quad 0x1000
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =kcfi_target
    ldr x0, [x0]
    ldr x0, =kcfi_msg
    bl printk
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kcfi_msg_exit
    bl printk
    ret
.section .rodata
kcfi_msg:
    .asciz "Kernel CFI Evasion executed\n"
kcfi_msg_exit:
    .asciz "Kernel CFI Evasion module deactivated\n"
