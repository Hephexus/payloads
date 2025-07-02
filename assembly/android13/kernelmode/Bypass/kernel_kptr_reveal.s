/*
 * kernel_kptr_reveal.s - Kernel Pointer Reveal Exploit
 *
 * Writes a dummy kernel pointer into a memory location and logs its “leak.”
 */
.extern printk
.section .data
kptr_value:
    .quad 0xDEADBEEFDEADBEEF
kptr_msg:
    .asciz "Kernel pointer: 0xDEADBEEFDEADBEEF\n"
 
.section .text
.global init_module
.global cleanup_module
init_module:
    mov x0, #1
    adr x1, kptr_msg
    mov x2, #42
    mov x8, #64
    svc 0
    mov x0, #0
    ret
cleanup_module:
    ret
