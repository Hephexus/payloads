/*
 * instruction_counter.s - Counts iterations in a loop and outputs the count in hexadecimal.
 *
 * Category: User‑Mode Demo
 *
 * This program loops 100 times, counts the iterations, converts the count to hex,
 * and prints it preceded by "Count: ".
 */
    .section .data
count_message:
    .asciz "Count: "
    .section .bss
    .lcomm hex_buffer, 18    // Buffer for hex conversion.
    .section .text
    .global main
main:
    mov x1, #0       // Counter = 0.
    mov x2, #100     // Loop 100 iterations.
count_loop:
    add x1, x1, #1
    subs x2, x2, #1
    bne count_loop

    mov x0, x1       // Prepare counter for conversion.
    bl num_to_hex

    mov x0, 1       // stdout.
    adr x3, count_message
    mov x2, #7      // "Count: " is 7 bytes.
    mov x8, 64
    svc 0

    mov x0, 1      // stdout.
    adr x1, hex_buffer
    mov x2, #17    // 16 digits + newline.
    mov x8, 64
    svc 0

    mov x0, 0
    mov x8, 93
    svc 0

// Subroutine: num_to_hex
num_to_hex:
    mov x6, x0
    mov x7, #16
    mov x8, #60
    mov x4, #0
num_to_hex_loop2:
    lsr x9, x6, x8
    and x9, x9, #0xF
    cmp x9, #10
    blt less_than_ten2
    add x9, x9, #55
    b store_digit2
less_than_ten2:
    add x9, x9, #48
store_digit2:
    adr x10, hex_buffer
    add x10, x10, x4
    strb w9, [x10]
    add x4, x4, #1
    subs x7, x7, #1
    sub x8, x8, #4
    b.ne num_to_hex_loop2
    adr x10, hex_buffer
    add x10, x10, x4
    mov w11, #10
    strb w11, [x10]
    ret
