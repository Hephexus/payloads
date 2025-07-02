/*
 * resource_usage_reporter.s - Resource Usage Reporter Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program prints a fixed message reporting CPU and memory usage.
 */
.section .data
usage_msg:
    .asciz "CPU: 10% MEM: 512MB\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, usage_msg
    mov x2, #22             // message length (22 bytes)
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
