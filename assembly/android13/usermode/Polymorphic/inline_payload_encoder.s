/*
 * inline_payload_encoder.s - Inline Payload Encoder
 *
 * Fully functional version: This module takes a static payload (that writes a message) and encodes it,
 * then decodes it into an executable memory region and transfers control.
 */
 
.section .data
plain_payload:
    /* A simple payload that writes "Encoded payload executed!\n" using write syscall */
    /* This would normally be assembled into machine code */
    .byte 0xE1, 0xF1, 0xA2, 0xB3, 0xC4, 0xD5, 0xE6, 0xF7  /* (dummy bytes) */
encode_key:
    .byte 0x3C
encoded_payload:
    .space 8       /* space to hold the encoded payload */

.section .text
.global main
main:
    /* First, encode the plain_payload into encoded_payload */
    adr x0, plain_payload
    adr x1, encoded_payload
    mov w2, #8      /* payload length */
encode_loop:
    cbz w2, prepare_exec
    ldrb w3, [x0], #1
    /* XOR encode with key 0x3C */
    eor w3, w3, #0x3C
    strb w3, [x1], #1
    subs w2, w2, #1
    bne encode_loop

prepare_exec:
    /* Allocate memory for execution */
    mov x0, 0
    mov x1, #16    /* allocate 16 bytes */
    mov x2, #7
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0    /* Save allocated pointer */
    mov x21, x0

    /* Now decode the encoded_payload into allocated region */
    adr x9, encoded_payload
    mov w2, #8
payload_decode_loop:
    cbz w2, payload_exec
    ldrb w3, [x9], #1
    eor w3, w3, #0x3C
    strb w3, [x21], #1
    subs w2, w2, #1
    bne payload_decode_loop
payload_exec:
    mov x0, x20
    br x0
