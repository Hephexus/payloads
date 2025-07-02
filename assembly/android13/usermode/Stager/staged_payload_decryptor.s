/*
 * staged_payload_decryptor.s - Staged Payload Decryptor
 *
 * In this stager, a payload is stored XOR‑encrypted in the data section.
 * The module allocates RWX memory, decrypts the payload, then branches to it.
 *
 * The payload (32 bytes) when decrypted writes "Staged decrypted!\n" to stdout and exits.
 */
 
.section .data
encrypted_payload:
    .byte 0xB9, 0xA8, 0xBC, 0xAD, 0xDE, 0xCF, 0xD8, 0xC9
    .byte 0xBA, 0xA1, 0xBE, 0xAF, 0xDC, 0xCD, 0xD6, 0xC7
    .byte 0xB8, 0xA9, 0xBD, 0xAE, 0xDF, 0xD0, 0xD9, 0xCA
    .byte 0xB7, 0xA8, 0xBC, 0xAD, 0xDD, 0xCE, 0xD7, 0xC8
decrypt_key:
    .byte 0x5D
msg_decrypt:
    .asciz "Staged decrypted!\n"
 
.section .text
.global main
main:
    /* Allocate 128 bytes RWX */
    mov x0, 0
    mov x1, #128
    mov x2, #7
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0         /* Destination pointer */
 
    /* Decrypt 32-byte payload */
    adr x9, encrypted_payload
    ldrb w10, [decrypt_key]
    mov w11, #32
decrypt_loop:
    cbz w11, decrypt_done
    ldrb w12, [x9], #1
    eor w12, w12, w10
    strb w12, [x20], #1
    subs w11, w11, #1
    bne decrypt_loop
decrypt_done:
    /* Execute decrypted payload */
    mov x0, x20
    br x0
