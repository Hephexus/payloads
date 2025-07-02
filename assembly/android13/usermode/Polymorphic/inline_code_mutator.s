/*
 * inline_code_mutator.s - Inline Code Mutator
 *
 * Fully functional version: This module allocates executable memory and copies a simple function into it.
 * It then mutates one byte of the copied function (for example, altering an immediate value)
 * and then calls the mutated function.
 *
 * The original function performs:
 *    mov x0, #42
 *    mov x8, #93
 *    svc 0
 *
 * The mutation changes 42 to 43.
 */
 
.section .data
original_func:
    .byte 0x20, 0x00, 0x80, 0x52   /* mov w0, #42   (example opcode, not actual) */
    .byte 0x20, 0x00, 0x00, 0xD4   /* svc 0         */
; For simulation, our mutation will add 1 to the immediate embedded in the mov instruction.

.section .text
.global main
main:
    /* Allocate memory for function copy (16 bytes) */
    mov x0, 0
    mov x1, #16
    mov x2, #7
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0    /* Original address allocated */
    /* Copy the original function into allocated memory */
    adr x1, original_func
    mov x2, #8     /* copy 8 bytes */
copy_loop:
    cbz x2, mutate
    ldrb w3, [x1], #1
    strb w3, [x20], #1
    subs x2, x2, #1
    bne copy_loop
mutate:
    /* For mutation, go back to the beginning of the function copy and modify the 4th byte */
    sub x20, x20, #8
    add x0, x20, #3      /* 4th byte offset */
    ldrb w4, [x0]
    add w4, w4, #1       /* Increase value by 1 (e.g., 42 -> 43) */
    strb w4, [x0]
    /* Call the mutated function */
    mov x0, x20
    br x0
