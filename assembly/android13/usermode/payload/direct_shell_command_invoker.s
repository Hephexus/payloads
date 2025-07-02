/*
 * direct_shell_command_invoker.s - Direct Shell Command Invoker Payload.
 *
 * This payload uses execve to launch a shell command from a provided buffer.
 * It prints "Direct Shell Command Invoker Executed\n" and then exits.
 */
.section .data
msg:
    .asciz "Direct Shell Command Invoker Executed\n"
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
