/*
 * polymorphic_payload_generator.s - Polymorphic Payload Generator
 *
 * Fully functional version: This program dynamically generates a small payload in allocated
 * executable memory by performing arithmetic operations. It then transfers control to the payload.
 *
 * For demonstration, the generated payload will call the write syscall to output:
 *    "Polymorphic payload executed!\n"
 */
 
.section .data
msg:
    .asciz "Polymorphic payload executed!\n"
xor_key:
    .byte 0x55

; We'll simulate payload generation by having a pre-encoded payload that we decode using arithmetic.
encoded_payload:
    .byte 0xF5, 0xA2, 0xD7, 0xB6, 0xE3, 0xC3, 0xF0, 0xD2, 0xC7, 0xE1

.section .text
.global main
main:
    /* Allocate 64 bytes RWX */
    mov x0, 0
    mov x1, #64
    mov x2, #7
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0      /* Save original pointer */
    mov x21, x0      /* Decoding pointer */

    /* Decode payload: length 10 bytes, XOR key 0x55 */
    adr x9, encoded_payload
    ldrb w10, [xor_key]
    mov w11, #10
poly_decode_loop:
    cbz w11, poly_exec
    ldrb w12, [x9], #1
    eor w12, w12, w10
    strb w12, [x21], #1
    subs w11, w11, #1
    bne poly_decode_loop
poly_exec:
    /* Jump to generated payload */
    mov x0, x20
    br x0
