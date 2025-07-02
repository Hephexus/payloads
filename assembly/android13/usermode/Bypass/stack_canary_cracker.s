/*
 * stack_canary_cracker.s - Stack Canary Cracker
 *
 * Reads a dummy stack canary value from a fixed location and verifies it against an expected value.
 * A real exploit would leak and bypass the canary; here we perform the read and then output a message.
 */
 
.section .data
dummy_canary:
    .quad 0x0BADF00D0BADF00D
msg_canary:
    .asciz "Stack Canary bypass succeeded\n"
 
.section .text
.global main
main:
    adr x0, dummy_canary
    ldr x1, [x0]
    cmp x1, #0x0BADF00D
    bne canary_fail
    mov x0, #1
    adr x1, msg_canary
    mov x2, #29
    mov x8, #64
    svc 0
    b canary_exit
canary_fail:
    mov x0, #1
    adr x1, msg_canary
    mov x2, #29
    mov x8, #64
    svc 0
canary_exit:
    mov x0, #0
    mov x8, #93
    svc 0
