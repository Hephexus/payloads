/*
 * timer_syscall_fuzzer.s - User-Mode Timer Syscall Fuzzer.
 *
 * This fuzzer repeatedly calls a dummy timer_create syscall (syscall number set as 222 for demo)
 * with fixed parameters and logs each iteration.
 */
 
.section .data
msg_timer:
    .asciz "Timer Syscall Fuzzer iteration complete\n"

.section .text
.global main
main:
    mov w0, #0
timer_loop:
    mov x0, #1          // clockid = CLOCK_REALTIME
    sub sp, sp, #16     // allocate space for timer id
    mov x1, sp          // pointer for timer id
    mov x2, #0          // timer_spec = NULL
    mov x8, #222        // dummy timer_create syscall
    svc 0
    add sp, sp, #16
    mov x0, #1
    adr x1, msg_timer
    mov x2, #39
    mov x8, #64
    svc 0
    add w0, w0, #1
    cmp w0, #3
    blt timer_loop
    mov x0, #0
    mov x8, #93
    svc 0
