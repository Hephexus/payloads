/*
 * self_modifying_code.s - Demonstrates self-modifying code.
 *
 * Category: User‑Mode Payload
 *
 * This program overwrites a NOP instruction with a branch to a subroutine,
 * then branches to that location to execute the modified code.
 */
    .section .data
msg_smc:
    .asciz "Self modifying code executed!\n"
    .section .text
    .global main
main:
    // Get the address of the target instruction.
    adr x0, smc_target
    // Calculate the branch offset to smc_sub.
    adr x1, smc_sub
    sub x2, x1, x0       // Compute offset.
    asr x2, x2, #2       // Divide offset by 4.
    and x2, x2, #0x03FFFFFF
    orr w2, w2, #0x14000000  // Build B (branch) instruction.
    // Overwrite the NOP at smc_target.
    str w2, [x0]
    // Branch to the modified instruction.
    br x0

smc_target:
    nop
smc_sub:
    // Print message.
    mov x0, 1
    adr x1, msg_smc
    mov x2, #29       // "Self modifying code executed!\n" is 29 bytes.
    mov x8, 64
    svc 0
    // Exit.
    mov x0, 0
    mov x8, 93
    svc 0
