/*
 * syscall_stack_pivot_payload.s - Syscall Stack Pivot Payload.
 *
 * This payload demonstrates a stack pivot technique in user mode.
 * It prints "Syscall Stack Pivot Payload Executed\n".
 */
.section .data
msg:
    .asciz "Syscall Stack Pivot Payload Executed\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg
    mov x2, #44        // 44 bytes message.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
