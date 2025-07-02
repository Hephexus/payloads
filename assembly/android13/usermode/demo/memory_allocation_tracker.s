/*
 * memory_allocation_tracker.s - Demonstrates querying the current program break.
 *
 * Category: User‑Mode Demo
 *
 * This program calls brk(0) to obtain the current program break,
 * converts it to hexadecimal, and prints it.
 */
.section .data
msg_brk:
    .asciz "Current break: "
.section .bss
    .lcomm brk_hex, 18
.section .text
.global main
main:
    mov x0, 0         // Argument 0 to brk.
    mov x8, 214       // syscall: brk.
    svc 0             // Current break returned in x0.
    // Convert pointer in x0 to hex.
    mov x3, x0
    bl num_to_hex_brk
    // Print message.
    mov x0, 1         // stdout.
    adr x1, msg_brk
    mov x2, #15      // message length.
    mov x8, 64
    svc 0
    // Print hex value.
    mov x0, 1
    adr x1, brk_hex
    mov x2, #17
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0

num_to_hex_brk:
    mov x6, x3
    mov x7, #16
    mov x8, #60
    mov x4, #0
num_to_hex_loop_brk:
    lsr x9, x6, x8
    and x9, x9, #0xF
    cmp x9, #10
    blt less_than_ten_brk
    add x9, x9, #55
    b store_digit_brk
less_than_ten_brk:
    add x9, x9, #48
store_digit_brk:
    adr x10, brk_hex
    add x10, x10, x4
    strb w9, [x10]
    add x4, x4, #1
    subs x7, x7, #1
    sub x8, x8, #4
    b.ne num_to_hex_loop_brk
    adr x10, brk_hex
    add x10, x10, x4
    mov w11, #10
    strb w11, [x10]
    ret
