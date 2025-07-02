/*
 * simulated_stack_canary_checker.s - Simulates a stack canary check.
 *
 * Category: User‑Mode Demo
 *
 * This program prints "Stack Canary OK\n" to indicate a successful check.
 */
    .section .data
canary_msg:
    .asciz "Stack Canary OK\n"
    .section .text
    .global main
main:
    mov x0, 1          // stdout.
    adr x1, canary_msg
    mov x2, #17      // Length of "Stack Canary OK\n" (17 bytes).
    mov x8, 64      // syscall: write.
    svc 0
    mov x0, 0
    mov x8, 93      // syscall: exit.
    svc 0
