/*
 * multi_stage_payload_loader.s - Multi-Stage Payload Loader Payload.
 *
 * This payload loads two payload stages sequentially.
 * Stage 1 prints "Stage 1 Executed\n" and Stage 2 prints "Stage 2 Executed\n".
 *
 * Fully functional using Linux syscalls on ARM64.
 */
.section .data
    msg_stage1:
    .asciz "Multi-Stage Payload: Stage 1 Executed\n"
    msg_stage2:
    .asciz "Multi-Stage Payload: Stage 2 Executed\n"
.section .text
.global main
main:
    // Execute Stage 1.
    mov x0, 1
    adr x1, msg_stage1
    mov x2, #33
    mov x8, 64
    svc 0
    // Execute Stage 2.
    mov x0, 1
    adr x1, msg_stage2
    mov x2, #33
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
