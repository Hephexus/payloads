/*
 * chained_payload_executer.s - Chained Payload Executer
 *
 * This stager contains two payload stages embedded in its data section.
 * The first stage prints a message and then jumps to the second stage.
 *
 * Stage 1 and Stage 2 are each 16 bytes in length.
 */
 
.section .data
stage1:
    /* Stage 1 payload: print "Stage1 executed\n" then jump */
    ; (Actual opcodes must be generated; here we use dummy bytes)
    .byte 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF, 0x11, 0x22
    .byte 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0x00
stage2:
    /* Stage 2 payload: print "Stage2 executed\n" then exit */
    .byte 0x99, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22
    .byte 0x11, 0x00, 0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA
 
.section .text
.global main
main:
    /* Allocate 256 bytes RWX */
    mov x0, 0
    mov x1, #256
    mov x2, #7
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0    /* Pointer to allocated region */

    /* Copy Stage 1 payload (16 bytes) */
    adr x1, stage1
    mov w2, #16
chain_loop1:
    cbz w2, chain_done1
    ldrb w3, [x1], #1
    strb w3, [x20], #1
    subs w2, w2, #1
    bne chain_loop1
chain_done1:
    /* Copy Stage 2 payload (16 bytes) */
    adr x1, stage2
    mov w2, #16
chain_loop2:
    cbz w2, chain_done2
    ldrb w3, [x1], #1
    strb w3, [x20], #1
    subs w2, w2, #1
    bne chain_loop2
chain_done2:
    /* Execute the combined payload */
    mov x0, x20
    br x0
