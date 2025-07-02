/*
 * embedded_disassembler.s - Simulates an embedded disassembler.
 *
 * Category: User‑Mode Demo
 *
 * This program prints "Disassembler: Not Implemented\n".
 */
    .section .data
disasm_msg:
    .asciz "Disassembler: Not Implemented\n"
    .section .text
    .global main
main:
    mov x0, 1         // stdout.
    adr x1, disasm_msg
    mov x2, #30       // Length of message (30 bytes).
    mov x8, 64      // syscall: write.
    svc 0
    mov x0, 0
    mov x8, 93     // syscall: exit.
    svc 0
