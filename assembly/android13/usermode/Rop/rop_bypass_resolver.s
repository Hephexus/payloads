/*
 * rop_bypass_resolver.s - ROP Bypass Resolver
 *
 * This module demonstrates bypassing NX by changing memory protection on an allocated region.
 * It allocates memory with non‐executable protection, calls mprotect to set it executable, then
 * transfers control to a payload that writes "Bypass Resolver executed!\n".
 */
 
.section .data
payload_bp:
    /* Dummy payload: write a message then exit */
    mov x0, #1
    adr x1, bp_msg
    mov x2, #31
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0
bp_msg:
    .asciz "Bypass Resolver executed!\n"
 
.section .text
.global main
main:
    /* Allocate memory without exec permissions: PROT_READ|PROT_WRITE = 3 */
    mov x0, 0
    mov x1, #64
    mov x2, #3
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0

    /* Now change protection to PROT_READ|PROT_WRITE|PROT_EXEC (7) using mprotect syscall (syscall 226 on ARM64) */
    mov x0, x20
    mov x1, #64
    mov x2, #7
    mov x8, #226
    svc 0

    /* Copy our payload into the now-executable region; assume payload is 32 bytes */
    adr x1, payload_bp
    mov w2, #32
copy_bp:
    cbz w2, bp_exec
    ldrb w3, [x1], #1
    strb w3, [x20], #1
    subs w2, w2, #1
    bne copy_bp
bp_exec:
    mov x0, x20
    br x0
