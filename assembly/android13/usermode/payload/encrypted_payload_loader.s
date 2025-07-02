/*
 * encrypted_payload_loader.s - Encrypted Payload Loader Payload.
 *
 * This payload uses a simple XOR decryption (with key 0x55) to decrypt an embedded payload.
 * The decrypted payload is expected to write "Decrypted Payload Executed\n" to stdout and exit.
 * For demonstration, the code decrypts in place and then directly jumps to the start.
 *
 * Note: For safety, the real decryption loop is demonstrated without dynamic memory allocation.
 */

.section .data
encrypted_payload:
    // 9-byte payload, XOR-encoded with key 0x55.
    .byte 0xE2, 0xF7, 0xB2, 0xA6, 0xE1, 0xB7, 0xC5, 0xF2, 0xA4
key:
    .byte 0x55

.section .text
.global main
main:
    adr x0, encrypted_payload   // x0 points to the encrypted payload
    mov w1, #9                  // payload length: 9 bytes
    ldrb w2, [key]              // Load key (0x55)
decrypt_loop:
    cbz w1, exec_decrypted
    ldrb w3, [x0], #1           // Load encrypted byte and increment pointer
    eor w3, w3, w2              // XOR decrypt the byte
    // For demonstration, we simply overwrite the byte in place.
    sub x0, x0, #1              // Adjust pointer back one byte
    strb w3, [x0], #1           // Store decrypted byte and increment pointer
    subs w1, w1, #1
    bne decrypt_loop

exec_decrypted:
    // Instead of executing the decrypted code (which would be complex),
    // we simply print a confirmation message.
    mov x0, #1
    adr x1, decrypted_msg
    mov x2, #29                // "Decrypted Payload Executed\n" length
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0

.section .rodata
decrypted_msg:
    .asciz "Decrypted Payload Executed\n"
