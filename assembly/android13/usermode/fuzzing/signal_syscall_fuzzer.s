/*
 * signal_syscall_fuzzer.s - User-Mode Signal Syscall Fuzzer.
 *
 * This fuzzer iterates over signal numbers 1 to 9 and calls rt_sigaction with a dummy action.
 */
 
.section .data
msg_signal:
    .asciz "Signal Syscall Fuzzer iteration complete\n"

.section .text
.global main
main:
    mov w0, #1    // Starting signal number
sig_loop:
    sub sp, sp, #32   // Allocate dummy action struct space
    mov x1, sp       // Pointer to action
    mov x2, #0       // old action = NULL
    mov x8, #134     // rt_sigaction syscall
    svc 0
    add sp, sp, #32
    mov x0, #1
    adr x1, msg_signal
    mov x2, #43
    mov x8, #64
    svc 0
    add w0, w0, #1
    cmp w0, #10
    blt sig_loop
    mov x0, #0
    mov x8, #93
    svc 0
