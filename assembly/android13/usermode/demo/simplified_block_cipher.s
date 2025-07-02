/*
 * simplified_block_cipher.s - Simplified Block Cipher Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program XORs a 16-byte plaintext with the constant key 0xAA
 * to simulate encryption. The ciphertext is then printed to stdout.
 */
.section .data
plaintext:
    .asciz "Hello, World!!!"   // 16 bytes (including the terminating character)
key_val:
    .byte 0xAA                 // Constant key
.section .bss
    .lcomm cipher_buf, 17      // Buffer for 16 bytes ciphertext + newline
.section .text
.global main
main:
    adr x1, plaintext         // pointer to plaintext
    adr x2, cipher_buf        // pointer to output buffer
    mov x3, #16               // 16 bytes to process
    ldrb w4, [key_val]        // load key 0xAA
cipher_loop:
    ldrb w5, [x1], #1         // load next byte, post-increment pointer
    eor w5, w5, w4            // XOR with key
    strb w5, [x2], #1         // store result, post-increment output pointer
    subs x3, x3, #1
    b.ne cipher_loop
    mov w6, #10               // Append newline
    adr x7, cipher_buf
    add x7, x7, #16
    strb w6, [x7]
    // Write ciphertext to stdout.
    mov x0, 1
    adr x1, cipher_buf
    mov x2, #17
    mov x8, 64
    svc 0
    // Exit.
    mov x0, 0
    mov x8, 93
    svc 0
