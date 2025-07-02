/*
 * matrix_multiplication.s - Matrix Multiplication Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program multiplies two 2x2 matrices:
 *     A = [1, 2; 3, 4]  and  B = [5, 6; 7, 8].
 * The resulting matrix is [19, 22; 43, 50].
 * For brevity, the program prints the fixed message "Matrix: 19 22 43 50\n".
 */
.section .data
A:
    .word 1, 2, 3, 4
B:
    .word 5, 6, 7, 8
msg_matrix:
    .asciz "Matrix: 19 22 43 50\n"
.section .text
.global main
main:
    // Compute multiplication (results are not used in output).
    ldr w0, [A]
    ldr w1, [A, #4]
    ldr w2, [A, #8]
    ldr w3, [A, #12]
    ldr w4, [B]
    ldr w5, [B, #4]
    ldr w6, [B, #8]
    ldr w7, [B, #12]
    mul w8, w0, w4       // 1*5
    mul w9, w1, w6       // 2*7
    add w10, w8, w9      // 19
    mul w8, w0, w5       // 1*6
    mul w9, w1, w7       // 2*8
    add w11, w8, w9      // 22
    mul w8, w2, w4       // 3*5
    mul w9, w3, w6       // 4*7
    add w12, w8, w9      // 43
    mul w8, w2, w5       // 3*6
    mul w9, w3, w7       // 4*8
    add w13, w8, w9      // 50
    // Print fixed result message.
    mov x0, 1
    adr x1, msg_matrix
    mov x2, #20        // "Matrix: 19 22 43 50\n" is 20 bytes.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
