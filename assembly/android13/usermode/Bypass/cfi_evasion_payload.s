/*
 * cfi_evasion_payload.s - CFI Evasion Payload
 *
 * Reads a value from a designated memory location, computes a jump target at runtime,
 * and then branches to it. This simulates evading Control Flow Integrity checks.
 *
 * (A real evasion payload would use obfuscated jump sequences.)
 */
 
.section .data
target_ptr:
    .quad 0x1000        /* Assume this is computed dynamically */
cfi_msg:
    .asciz "CFI Evasion Payload executed!\n"
 
.section .text
.global main
main:
    ldr x0, =target_ptr
    ldr x0, [x0]
    /* For safety, instead of branching to x0, we output a message */
    mov x0, #1
    ldr x1, =cfi_msg
    mov x2, #31
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0
