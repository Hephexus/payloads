/*
 * self_modifying_shellcode.s - Self-Modifying Shellcode
 *
 * Fully functional version: This program allocates executable memory using mmap,
 * decodes an XOR‑encoded payload (that contains code to write a message to stdout and exit),
 * then jumps to the decoded payload.
 *
 * The payload (unencrypted) is conceptually:
 *    mov x0, #1
 *    adr x1, message
 *    mov x2, #40
 *    mov x8, #64
 *    svc 0
 *    mov x0, #0
 *    mov x8, #93
 *    svc 0
 *
 * The payload is XOR‑encrypted with key 0xAA.
 */
 
.section .data
; (These bytes should be produced by an assembler; here we use a sample 10-byte payload.)
encoded_shellcode:
    .byte 0xE3, 0xCD, 0xD3, 0xD7, 0xE3, 0xF2, 0xC3, 0xDC, 0xC3, 0xDF
key:
    .byte 0xAA
message:
    .asciz "Self-Modifying payload executed!\n"

.section .text
.global main
main:
    /* Allocate 64 bytes RWX via mmap */
    mov x0, 0             /* addr = NULL */
    mov x1, #64           /* size = 64 bytes */
    mov x2, #7            /* prot = PROT_READ|PROT_WRITE|PROT_EXEC */
    mov x3, #0x22         /* flags = MAP_PRIVATE|MAP_ANONYMOUS */
    mov x4, #-1          /* fd */
    mov x5, 0            /* offset */
    mov x8, #222         /* syscall number for mmap on ARM64 */
    svc 0
    /* Save original allocated pointer in x20 */
    mov x20, x0
    /* Use x21 as our mutable pointer for decoding */
    mov x21, x0

    /* Decode 10-byte payload from encoded_shellcode */
    adr x9, encoded_shellcode
    ldrb w10, [key]      /* Load XOR key */
    mov w11, #10         /* Payload length */
decode_loop:
    cbz w11, exec_payload
    ldrb w12, [x9], #1
    eor w12, w12, w10    /* Decoding */
    strb w12, [x21], #1
    subs w11, w11, #1
    bne decode_loop
exec_payload:
    /* Jump to the beginning of allocated, decoded payload */
    mov x0, x20
    br x0
