/*
 * resource_limit_fuzzer.s - User-Mode Resource Limit Fuzzer.
 *
 * This fuzzer simulates calls to setrlimit() (using a dummy syscall number 160) with varying limits.
 */
 
.section .data
msg_rlimit:
    .asciz "Resource Limit Fuzzer iteration complete\n"

.section .bss
    .lcomm rlimit_buf, 16

.section .text
.global main
main:
    mov w0, #0
rlimit_loop:
    mov w1, w0
    adr x2, rlimit_buf
    str w1, [x2]
    str w1, [x2, #4]
    mov x0, #0         // RLIMIT_CPU as example
    mov x8, #160       // dummy setrlimit syscall
    svc 0
    mov x0, #1
    adr x1, msg_rlimit
    mov x2, #41
    mov x8, #64
    svc 0
    add w0, w0, #1
    cmp w0, #3
    blt rlimit_loop
    mov x0, #0
    mov x8, #93
    svc 0
