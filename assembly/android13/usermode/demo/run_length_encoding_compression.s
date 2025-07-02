/*
 * run_length_encoding_compression.s - Run-Length Encoding (RLE) Compression Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program simulates RLE compression for the string "AAABB". It then
 * prints the fixed compressed result "3A2B\n".
 */
.section .data
msg_rle:
    .asciz "3A2B\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg_rle
    mov x2, #6       // "3A2B\n" is 6 bytes.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
