/*
 * dep_bypass_chain.s - DEP Bypass Chain
 *
 * Allocates a memory region without EXEC permissions, then calls mprotect to mark it executable,
 * simulating a bypass of DEP/NX using a ROP chain.
 */
 
.section .text
.global main
main:
    /* Allocate 256 bytes with RW only */
    mov x0, 0
    mov x1, #256
    mov x2, #3         /* PROT_READ|PROT_WRITE */
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0      /* Allocation pointer */
    /* Change protection to RWX using mprotect */
    mov x0, x20
    mov x1, #256
    mov x2, #7       /* PROT_READ|PROT_WRITE|PROT_EXEC */
    mov x8, #226
    svc 0
    /* Write a payload message in the allocated region */
    mov x0, #1
    ldr x1, =dep_msg
    mov x2, #30
    mov x8, #64
    svc 0
    /* Execute payload (branching to allocated memory) */
    mov x0, x20
    br x0
    mov x0, #0
    mov x8, #93
    svc 0
.section .data
dep_msg:
    .asciz "DEP Bypass Chain executed via ROP\n"
