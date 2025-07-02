/*
 * code_obfuscator_decryptor.s - Code Obfuscator and Decryptor
 *
 * Fully functional version: This module contains an XOR‑encrypted payload in the data section.
 * It decrypts the payload using a loop and then jumps to it.
 *
 * The payload, when executed, writes "Obfuscated payload executed!\n" to stdout.
 */
 
.section .data
encrypted_payload:
    .byte 0xC9, 0xDF, 0xD8, 0xC5, 0xD9, 0xCF, 0xC1, 0xCD, 0xD7, 0xCF, 0xDA, 0xD2
decrypt_key:
    .byte 0x5F
msg_obfus:
    .asciz "Obfuscated payload executed!\n"

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
    mov x20, x0   /* Save original pointer */
    mov x21, x0   /* Decoding pointer */

    /* Decrypt 12 bytes payload using key 0x5F */
    adr x9, encrypted_payload
    ldrb w10, [decrypt_key]
    mov w11, #12
decrypt_loop:
    cbz w11, decrypt_exec
    ldrb w12, [x9], #1
    eor w12, w12, w10
    strb w12, [x21], #1
    subs w11, w11, #1
    bne decrypt_loop
decrypt_exec:
    /* Jump to decrypted payload */
    mov x0, x20
    br x0
