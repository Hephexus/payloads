/*
 * threading_with_clone_fork.s - Simulates creating a thread/fork.
 *
 * Category: User‑Mode Demo
 *
 * This program prints "Thread/Fork: Simulated\n" to indicate a simulated clone/fork.
 */
    .section .data
thread_msg:
    .asciz "Thread/Fork: Simulated\n"
    .section .text
    .global main
main:
    mov x0, 1         // stdout.
    adr x1, thread_msg
    mov x2, #24       // Length (24 bytes).
    mov x8, 64      // syscall: write.
    svc 0
    mov x0, 0
    mov x8, 93     // syscall: exit.
    svc 0
