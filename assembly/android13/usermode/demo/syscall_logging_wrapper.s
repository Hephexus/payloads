/*
 * syscall_logging_wrapper.s - Syscall Logging Wrapper Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program prints a log message before performing a write syscall to print a real message.
 */
.section .data
log_msg:
    .asciz "Logging syscall: write\n"
real_msg:
    .asciz "Real message\n"
.section .text
.global main
main:
    // Log the syscall.
    mov x0, 1
    adr x1, log_msg
    mov x2, #26             // length of log message
    mov x8, 64
    svc 0
    // Perform the real write syscall.
    mov x0, 1
    adr x1, real_msg
    mov x2, #14             // length of "Real message\n"
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
