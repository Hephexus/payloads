/*
 * crc_checksum_calculator.s - CRC Checksum Calculator Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program computes a simple checksum by summing the bytes of "123456789"
 * modulo 256. The resulting checksum is then converted to a two-digit hexadecimal number
 * and printed, preceded by "CRC: ".
 */
.section .data
data_str:
    .asciz "123456789"
msg_crc:
    .asciz "CRC: "
.section .bss
    .lcomm crc_hex, 18        // Buffer for hex output
.section .text
.global main
main:
    adr x0, data_str          // pointer to the data string
    mov x3, #0                // accumulator for checksum
calc_loop:
    ldrb w1, [x0], #1         // load byte and move pointer
    cbz w1, calc_done
    add x3, x3, x1
    and x3, x3, #0xFF         // mod 256
    b calc_loop
calc_done:
    // Convert the checksum in x3 into two hex digits.
    mov x4, x3
    udiv x5, x4, #16         // tens digit
    msub x6, x5, #16, x4      // ones digit
    add x5, x5, #48          // convert to ASCII
    add x6, x6, #48          // convert to ASCII
    adr x0, crc_hex
    strb w5, [x0]
    add x0, x0, #1
    strb w6, [x0]
    add x0, x0, #1
    mov w7, #10
    strb w7, [x0]
    // Print "CRC: " message.
    mov x0, 1
    adr x1, msg_crc
    mov x2, #5               // "CRC: " = 5 bytes
    mov x8, 64
    svc 0
    // Print checksum.
    mov x0, 1
    adr x1, crc_hex
    mov x2, #4               // 2 hex digits + newline (extra byte safe)
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
