/*
 * floating_point_emulation.s - Floating-Point Emulation Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program emulates simple floating-point arithmetic using integer operations.
 * For demonstration, it prints the fixed message "3.14 approx\n".
 */
.section .data
msg_fp:
    .asciz "3.14 approx\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg_fp
    mov x2, #14      // Message length: 14 bytes.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
