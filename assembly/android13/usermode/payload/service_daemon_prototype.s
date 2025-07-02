/*
 * service_daemon_prototype.s - A prototype service daemon.
 *
 * Category: User‑Mode Payload
 *
 * This program prints "Daemon running...\n" and then enters an infinite loop,
 * calling the pause syscall (assumed to be 35) to wait for signals.
 */
    .section .data
daemon_msg:
    .asciz "Daemon running...\n"
    .section .text
    .global main
main:
    mov x0, 1
    adr x1, daemon_msg
    mov x2, #18      // "Daemon running...\n" is 18 bytes.
    mov x8, 64
    svc 0
daemon_loop:
    mov x8, #35      // syscall: pause.
    svc 0
    b daemon_loop
