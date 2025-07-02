/*
 * user_mode_rop_chain_builder.s - User-Mode ROP Chain Builder Payload.
 *
 * This payload constructs and executes a simple return-oriented programming (ROP) chain.
 * It prints "User-Mode ROP Chain Builder Executed\n".
 */
.section .data
msg:
    .asciz "User-Mode ROP Chain Builder Executed\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg
    mov x2, #43        // 43 bytes message.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
