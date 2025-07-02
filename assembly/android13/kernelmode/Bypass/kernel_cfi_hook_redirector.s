/*
 * kernel_cfi_hook_redirector.s - Kernel CFI Hook Redirector
 *
 * Overwrites a dummy function pointer to simulate redirection.
 */
.extern printk
.section .bss
    .lcomm kcfih_ptr, 8
.section .text
.global init_module
.global cleanup_module
init_module:
    mov x0, #0xCAFED00DCAFED00D
    str x0, [kcfih_ptr]
    mov x0, #0xDEADC0DEDEADC0DE
    str x0, [kcfih_ptr]
    ldr x0, =kcfih_msg
    bl printk
    mov x0, #0
    ret
cleanup_module:
    mov x0, #0xCAFED00DCAFED00D
    str x0, [kcfih_ptr]
    ldr x0, =kcfih_msg_exit
    bl printk
    ret
.section .rodata
kcfih_msg:
    .asciz "Kernel CFI Hook Redirector executed\n"
kcfih_msg_exit:
    .asciz "Kernel CFI Hook Redirector module deactivated\n"
