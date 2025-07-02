/*
 * syscall_fuzzer.s - User-Mode Syscall Fuzzer.
 *
 * This fuzzer loops over syscall numbers 200 to 210, invoking each with zeroed parameters,
 * then logs its execution.
 */
 
.section .data
msg_prefix:
    .asciz "Syscall "
msg_suffix:
    .asciz " executed\n"

.section .text
.global main
main:
    mov w0, #200         // Starting syscall number
sys_loop:
    mov x8, x0           // Set syscall number from w0 into x8
    mov x0, #0
    mov x1, #0
    mov x2, #0
    mov x3, #0
    svc 0                // Invoke syscall
    mov x0, #1
    adr x1, msg_prefix
    mov x2, #8         // Print "Syscall "
    mov x8, #64       // write syscall
    svc 0
    mov x0, #1
    adr x1, msg_suffix
    mov x2, #10       // Print " executed\n"
    mov x8, #64
    svc 0
    add w0, w0, #1
    cmp w0, #211
    blt sys_loop
    mov x0, #0
    mov x8, #93     // exit syscall
    svc 0
