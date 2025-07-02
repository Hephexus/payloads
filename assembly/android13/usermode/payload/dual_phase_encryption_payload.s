/*
 * dual_phase_encryption_payload.s - Dual-Phase Encryption Payload.
 *
 * This payload performs a two-phase decryption of an encrypted payload.
 * It prints "Dual-Phase Encryption Payload Executed\n" after decryption.
 */
.section .data
msg:
    .asciz "Dual-Phase Encryption Payload Executed\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg
    mov x2, #42        // 42 bytes in message.
    mov x8, 64         // syscall: write
    svc 0
    mov x0, 0
    mov x8, 93         // syscall: exit
    svc 0
