/*
 * terminal_emulator_skeleton.s - Provides a minimal terminal interface skeleton.
 *
 * Category: User‑Mode Demo
 *
 * This program prints "Terminal: Ready\n".
 */
    .section .data
terminal_msg:
    .asciz "Terminal: Ready\n"
    .section .text
    .global main
main:
    mov x0, 1         // stdout.
    adr x1, terminal_msg
    mov x2, #16       // Length of message (16 bytes).
    mov x8, 64     // syscall: write.
    svc 0
    mov x0, 0
    mov x8, 93     // syscall: exit.
    svc 0
