/*
 * system_uptime_reporter.s - Reports system uptime.
 *
 * Category: User‑Mode Demo
 *
 * This program prints a fixed uptime message.
 */
    .section .data
uptime_msg:
    .asciz "Uptime: 12345 seconds\n"
    .section .text
    .global main
main:
    mov x0, 1          // stdout.
    adr x1, uptime_msg
    mov x2, #23       // Length of "Uptime: 12345 seconds\n" (23 bytes).
    mov x8, 64       // syscall: write.
    svc 0
    mov x0, 0
    mov x8, 93       // syscall: exit.
    svc 0
