/*
 * optimized_string_operations.s - Optimized String Comparison Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program compares the two strings "Test" and "Test" byte-by-byte.
 * If they match, it prints "Equal\n"; otherwise, "Not Equal\n".
 */
.section .data
str1:
    .asciz "Test"
str2:
    .asciz "Test"
msg_equal:
    .asciz "Equal\n"
msg_not_equal:
    .asciz "Not Equal\n"
.section .text
.global main
main:
    adr x0, str1
    adr x1, str2
compare_loop:
    ldrb w2, [x0], #1
    ldrb w3, [x1], #1
    cmp w2, w3
    b.ne not_equal
    cbz w2, equal          // if end of string reached and equal, then equal
    b compare_loop
equal:
    adr x4, msg_equal
    b write_msg
not_equal:
    adr x4, msg_not_equal
write_msg:
    mov x0, 1               // stdout
    mov x1, x4
    // Determine length based on message.
    cmp x4, msg_equal
    b.eq set_equal_len
    mov x2, #10             // "Not Equal\n" assumed 10 bytes
    b do_write
set_equal_len:
    mov x2, #6              // "Equal\n" = 6 bytes
do_write:
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
