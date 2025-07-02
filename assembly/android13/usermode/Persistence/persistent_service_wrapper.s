/*
 * persistent_service_wrapper.s - Persistent Service Wrapper
 *
 * This module demonstrates persistence by launching a child process via vfork.
 * If the child process terminates, the parent will re-spawn it.
 *
 * Syscalls used: vfork (57) and exit (93).
 */
 
.section .data
msg_service:
    .asciz "Persistent Service: Child process launched\n"

.section .text
.global main
main:
    mov w0, #0
service_loop:
    mov x8, #57         /* vfork syscall */
    svc 0
    cmp x0, #0
    beq child_exit      /* In child process, exit immediately */
    ; Parent: log the event and then loop
    mov x0, #1
    adr x1, msg_service
    mov x2, #42
    mov x8, #64
    svc 0
    ; Delay briefly, then re-spawn (using a simple loop for delay)
    mov w3, #100000
delay_loop:
    subs w3, w3, #1
    bne delay_loop
    b service_loop

child_exit:
    mov x0, #0
    mov x8, #93
    svc 0
