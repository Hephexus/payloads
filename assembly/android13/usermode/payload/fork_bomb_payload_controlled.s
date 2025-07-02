/*
 * fork_bomb_payload_controlled.s - Fork Bomb Payload (Controlled).
 *
 * This payload demonstrates resource exhaustion via forking in a controlled manner.
 * It prints "Fork Bomb Payload Controlled Executed\n" without causing runaway forking.
 */
.section .data
msg:
    .asciz "Fork Bomb Payload Controlled Executed\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg
    mov x2, #45        // 45 bytes message.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
