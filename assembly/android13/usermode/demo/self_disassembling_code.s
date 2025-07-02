/*
 * self_disassembling_code.s - Self-Disassembling Code Demo.
 *
 * Category: User‑Mode Demo
 *
 * For demonstration, this program simply prints a self-disassembling stub message.
 */
.section .data
self_msg:
    .asciz "Self-disassembling stub\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, self_msg
    mov x2, #26             // message length (26 bytes)
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
