/*
 * self_relocating_stager.s - Self-Relocating Stager
 *
 * This module allocates memory for a payload, copies an embedded payload from data,
 * then performs a simulated relocation adjustment (by adding a fixed offset to a dummy register)
 * before executing the payload.
 *
 * This demonstrates dynamic relocation in shellcode.
 */
 
.section .data
embedded_payload:
    .byte 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF, 0x11, 0x22
    .byte 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0x00
msg_reloc:
    .asciz "Self-Relocating Stager executed\n"
 
.section .text
.global main
main:
    /* Allocate 128 bytes RWX */
    mov x0, 0
    mov x1, #128
    mov x2, #7
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0
  
    /* Copy embedded payload (16 bytes) into allocated memory */
    adr x1, embedded_payload
    mov w2, #16
copy_reloc:
    cbz w2, reloc_adjust
    ldrb w3, [x1], #1
    strb w3, [x20], #1
    subs w2, w2, #1
    bne copy_reloc
reloc_adjust:
    /* Simulate relocation: add offset 0x10 to the payload pointer (dummy adjustment) */
    add x21, x20, #0x10
    /* For demonstration, output a message before executing */
    mov x0, #1
    adr x1, msg_reloc
    mov x2, #36
    mov x8, #64
    svc 0
    /* Execute payload (jump to relocated pointer) */
    mov x0, x21
    br x0
