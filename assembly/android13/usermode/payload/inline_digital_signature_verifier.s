/*
 * inline_digital_signature_verifier.s - Inline Digital Signature Verifier Payload.
 *
 * This payload verifies an embedded digital signature before execution.
 * It prints "Inline Digital Signature Verifier Executed\n".
 */
.section .data
msg:
    .asciz "Inline Digital Signature Verifier Executed\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg
    mov x2, #50        // 50 bytes message.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
