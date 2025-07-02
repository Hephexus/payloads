/*
 * system_call_stress_fuzzer.s - User-Mode System Call Stress Fuzzer.
 *
 * This fuzzer issues a burst of write syscalls in a loop to stress-test the syscall interface.
 */
 
.section .data
msg_stress:
    .asciz "Syscall Stress Fuzzer iteration complete\n"

.section .text
.global main
main:
    mov w0, #0
stress_loop:
    mov x0, #1
    adr x1, msg_stress
    mov x2, #40
    mov x8, #64
    svc 0
    add w0, w0, #1
    cmp w0, #5
    blt stress_loop
    mov x0, #0
    mov x8, #93
    svc 0
