/*
 * arithmetic_calculator.s - Performs arithmetic addition and outputs the result.
 *
 * Category: User‑Mode Demo
 *
 * This program computes 15 + 27, converts the sum (42) to a two-digit ASCII string,
 * and prints "Result: 42\n".
 */
.section .data
msg_calc:
    .asciz "Result: "
.section .bss
    .lcomm num_buffer, 12
.section .text
.global main
main:
    mov x1, #15
    mov x2, #27
    add x3, x1, x2    // x3 = 42
    // Convert x3 (assumed two-digit) to ASCII digits.
    mov x4, x3
    udiv x5, x4, #10   // x5 = tens digit (4)
    msub x6, x5, #10, x4  // x6 = remainder (2)
    add x5, x5, #48    // Convert tens digit to ASCII.
    add x6, x6, #48    // Convert ones digit to ASCII.
    adr x0, num_buffer
    strb w5, [x0]
    add x0, x0, #1
    strb w6, [x0]
    add x0, x0, #1
    mov w7, #10       // Newline.
    strb w7, [x0]
    // Print the message.
    mov x0, 1         // stdout.
    adr x1, msg_calc
    mov x2, #8        // "Result: " is 8 bytes.
    mov x8, 64       // syscall: write.
    svc 0
    // Print the calculated result (3 bytes including newline).
    mov x0, 1
    adr x1, num_buffer
    mov x2, #3
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93      // exit.
    svc 0
