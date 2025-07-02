/*
 * library_function_reimplementation.s - Reimplements a basic library function.
 *
 * Category: User‑Mode Demo
 *
 * This program computes the length of "Hello, world!" and prints it as a single digit.
 * (For simplicity, we assume the length is a single digit.)
 */
    .section .data
test_str:
    .asciz "Hello, world!"
msg_prefix:
    .asciz "Length: "
    .section .bss
    .lcomm len_buffer, 18
    .section .text
    .global main
main:
    adr x0, test_str      // x0 points to the string.
    mov x3, #0            // Counter = 0.
strlen_loop:
    ldrb w4, [x0]
    cbz w4, strlen_done
    add x3, x3, #1
    add x0, x0, #1
    b strlen_loop
strlen_done:
    // Convert count (in x3) to an ASCII digit.
    add x5, x3, #48
    adr x0, len_buffer
    strb w5, [x0]
    add x0, x0, #1
    mov w6, #10         // Newline.
    strb w6, [x0]
    // Print the message prefix.
    mov x0, 1           // stdout.
    adr x1, msg_prefix
    mov x2, #8          // Length "Length: " is 8 bytes.
    mov x8, 64         // syscall: write.
    svc 0
    // Print the computed length.
    mov x0, 1          // stdout.
    adr x1, len_buffer
    mov x2, #2         // 1 digit + newline.
    mov x8, 64         // syscall: write.
    svc 0
    mov x0, 0
    mov x8, 93         // syscall: exit.
    svc 0
