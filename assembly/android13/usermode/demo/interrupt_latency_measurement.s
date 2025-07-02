/*
 * interrupt_latency_measurement.s - Simulates measuring interrupt latency.
 *
 * Category: User‑Mode Demo
 *
 * This program prints "Interrupt Latency: 100us\n".
 */
    .section .data
latency_msg:
    .asciz "Interrupt Latency: 100us\n"
    .section .text
    .global main
main:
    mov x0, 1         // stdout.
    adr x1, latency_msg
    mov x2, #27       // Length (27 bytes).
    mov x8, 64      // syscall: write.
    svc 0
    mov x0, 0
    mov x8, 93     // syscall: exit.
    svc 0
