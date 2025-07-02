/*
 * rop_detour_hook.s - ROP Detour Hook
 *
 * This module simulates hooking a function pointer in a global table by overwriting it with the address
 * of our shellcode payload, then calling through the pointer.
 * The payload will simply write "Detour executed!\n" using the write syscall.
 */
 
.section .data
; Dummy function pointer stored in a global variable.
fn_ptr:
    .quad 0x0

payload_detour:
    /* Simple payload: write "Detour executed!\n" to stdout and exit */
    mov x0, #1
    adr x1, detour_msg
    mov x2, #22
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0

detour_msg:
    .asciz "Detour executed!\n"
 
.section .text
.global main
main:
    /* Allocate memory for our payload_detour */
    mov x0, 0
    mov x1, #64
    mov x2, #7
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0

    /* Copy payload_detour (assume 32 bytes) */
    adr x1, payload_detour
    mov w2, #32
copy_detour:
    cbz w2, hook_done
    ldrb w3, [x1], #1
    strb w3, [x20], #1
    subs w2, w2, #1
    bne copy_detour
hook_done:
    /* Overwrite the dummy function pointer with our payload address */
    adr x0, fn_ptr
    str x20, [x0]
    /* Call through the function pointer */
    ldr x0, [x0]
    br x0
