/*
 * obfuscated_syscall_invoker.s - Obfuscated Syscall Invoker Payload.
 *
 * This payload performs arithmetic manipulations to obfuscate the syscall number for write,
 * then invokes write to print a message.
 *
 * Fully functional using Linux syscalls on ARM64.
 */
.section .data
    msg:
    .asciz "Obfuscated Syscall Invoker Executed\n"
.section .text
.global main
main:
    // Let’s obfuscate the write syscall number (64) by a reversible operation.
    mov x8, 64
    // For instance, subtract 10 then add 10.
    sub x8, x8, #10
    add x8, x8, #10
    mov x0, 1
    adr x1, msg
    mov x2, #36
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
