/*
 * env_variable_fuzzer.s - User-Mode Environment Variable Fuzzer.
 *
 * This fuzzer simulates retrieving environment variables by iterating over dummy variable names.
 */
 
.section .data
msg_env:
    .asciz "Env Variable Fuzzer iteration complete\n"

.section .text
.global main
main:
    mov w0, #0
env_loop:
    mov x0, #1
    adr x1, msg_env
    mov x2, #41
    mov x8, #64
    svc 0
    add w0, w0, #1
    cmp w0, #5
    blt env_loop
    mov x0, #0
    mov x8, #93
    svc 0
