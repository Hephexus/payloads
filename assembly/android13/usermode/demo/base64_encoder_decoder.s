/*
 * base64_encoder_decoder.s - Base64 Encoder/Decoder Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program encodes the 3-byte string "Man" into Base64.
 * It splits the 24-bit value into four 6-bit groups, looks them up in the Base64 table,
 * and prints the 4-character result "TWFu\n".
 */
.section .data
input_str:
    .byte 0x4d, 0x61, 0x6e      // "Man"
out_buf:
    .space 5                   // 4 characters + newline
base64_table:
    .asciz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
.section .text
.global main
main:
    // Load the three input bytes and combine them into a 24-bit integer.
    ldrb w0, [input_str]         // 'M'
    ldrb w1, [input_str, #1]     // 'a'
    ldrb w2, [input_str, #2]     // 'n'
    lsl x0, x0, #16              // shift first byte left 16 bits
    lsl x1, x1, #8               // shift second byte left 8 bits
    orr x0, x0, x1               // combine
    orr x0, x0, x2               // combine third byte
    mov x3, x0                   // x3 holds the 24-bit value

    // Extract four 6-bit groups.
    lsr x4, x3, #18             // group0 = bits 23-18
    and x4, x4, #0x3F
    lsr x5, x3, #12             // group1 = bits 17-12
    and x5, x5, #0x3F
    lsr x6, x3, #6              // group2 = bits 11-6
    and x6, x6, #0x3F
    and x7, x3, #0x3F           // group3 = bits 5-0

    // Lookup each index in the Base64 table.
    adr x8, base64_table
    add x9, x8, x4
    ldrb w10, [x9]
    adr x11, out_buf
    strb w10, [x11]
    add x11, x11, #1
    add x9, x8, x5
    ldrb w10, [x9]
    strb w10, [x11]
    add x11, x11, #1
    add x9, x8, x6
    ldrb w10, [x9]
    strb w10, [x11]
    add x11, x11, #1
    add x9, x8, x7
    ldrb w10, [x9]
    strb w10, [x11]
    add x11, x11, #1
    mov w12, #10                // newline
    strb w12, [x11]

    // Write the output buffer to stdout.
    mov x0, 1                   // file descriptor for stdout
    adr x1, out_buf
    mov x2, #5                  // 5 bytes to write
    mov x8, 64                  // syscall number for write
    svc 0

    // Exit the program.
    mov x0, 0
    mov x8, 93                  // syscall number for exit
    svc 0
