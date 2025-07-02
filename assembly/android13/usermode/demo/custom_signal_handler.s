/*
 * custom_signal_handler.s - Installs a custom signal handler.
 *
 * Category: User‑Mode Demo
 *
 * This program uses the rt_sigaction syscall to install a (dummy) signal handler for SIGINT.
 * It then prints "Signal Handler Set Up\n" and calls pause to wait indefinitely.
 */
.section .data
msg_sig_setup:
    .asciz "Signal Handler Set Up\n"
.section .text
.global main
main:
    // Set up (dummy) handler for SIGINT.
    mov x0, #2       // SIGINT.
    mov x1, 0        // new action: NULL (handler ignored).
    mov x2, 0        // old action: NULL.
    mov x3, #8       // size of sigset_t (assumed 8 bytes).
    mov x8, 134      // syscall: rt_sigaction.
    svc 0
    // Print setup message.
    mov x0, 1       // stdout.
    adr x1, msg_sig_setup
    mov x2, #23     // length of "Signal Handler Set Up\n".
    mov x8, 64
    svc 0
    // Wait indefinitely.
    mov x0, 0
    mov x8, 34      // syscall: pause.
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
