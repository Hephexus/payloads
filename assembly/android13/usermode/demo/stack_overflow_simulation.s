/*
 * stack_overflow_simulation.s - Stack Overflow Simulation Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program simulates a stack overflow detection scenario by printing
 * the message "Stack Overflow Detected\n".
 */
.section .data
msg_stack:
    .asciz "Stack Overflow Detected\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg_stack
    mov x2, #27       // Message length (27 bytes).
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
