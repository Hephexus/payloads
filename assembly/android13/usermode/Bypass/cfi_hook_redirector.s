/*
 * cfi_hook_redirector.s - CFI Hook Redirector
 *
 * Overwrites a dummy function pointer with a new value to simulate redirection of control flow.
 */
 
.section .data
fn_ptr:
    .quad 0xCAFEBABECAFEBABE
msg_cfi:
    .asciz "CFI Hook Redirector executed\n"
 
.section .text
.global main
main:
    mov x0, #0xDEADC0DEDEADC0DE
    adr x1, fn_ptr
    str x0, [x1]         /* Overwrite function pointer */
    mov x0, #1
    adr x1, msg_cfi
    mov x2, #31
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0
