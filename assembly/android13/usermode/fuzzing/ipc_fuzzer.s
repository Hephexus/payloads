/*
 * ipc_fuzzer.s - User-Mode IPC Fuzzer.
 *
 * This fuzzer creates a pipe using pipe2 with the O_CLOEXEC flag and logs the result.
 */
 
.section .data
msg_ipc:
    .asciz "IPC Fuzzer iteration complete\n"

.section .text
.global main
main:
    sub sp, sp, #16     // Allocate space for pipefd[2]
    mov x0, sp
    mov x1, #0x80000    // O_CLOEXEC
    mov x8, #59         // pipe2 syscall
    svc 0
    add sp, sp, #16
    mov x0, #1
    adr x1, msg_ipc
    mov x2, #36
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0
