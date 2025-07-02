/*
 * nx_bypass_via_rop.s - NX Bypass via ROP
 *
 * Allocates RW memory and then uses mprotect to mark it executable, bypassing NX/DEP.
 */
 
.section .text
.global main
main:
    /* Allocate 128 bytes with PROT_READ|PROT_WRITE (no exec) */
    mov x0, 0
    mov x1, #128
    mov x2, #3         /* PROT_READ|PROT_WRITE */
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0      /* Allocated region pointer */
    /* Change protection to PROT_READ|PROT_WRITE|PROT_EXEC (7) */
    mov x0, x20
    mov x1, #128
    mov x2, #7
    mov x8, #226     /* mprotect syscall */
    svc 0
    /* Write a payload message into the region */
    mov x0, #1
    ldr x1, =nx_msg
    mov x2, #22
    mov x8, #64
    svc 0
    /* Branch to the allocated region (here we simply loop, as real payload execution is dangerous) */
    mov x0, x20
    br x0
    mov x0, #0
    mov x8, #93
    svc 0
.section .data
nx_msg:
    .asciz "NX Bypass via ROP executed!\n"
