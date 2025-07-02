/*
 * inline_assembly_in_c_integration_sample.s - Demonstrates embedding assembly in C.
 *
 * Category: User‑Mode Demo
 *
 * This file provides a function "asm_function" that prints a demo message.
 * Intended to be assembled and linked with a C program.
 */
.section .data
asm_msg:
    .asciz "Inline Assembly Integration Demo\n"
.section .text
.global asm_function
asm_function:
    mov x0, 1       // stdout.
    adr x1, asm_msg
    mov x2, #33     // message length (33 bytes).
    mov x8, 64      // syscall: write.
    svc 0
    ret

.global main
main:
    // For standalone testing, call asm_function.
    bl asm_function
    mov x0, 0
    mov x8, 93     // syscall: exit.
    svc 0
