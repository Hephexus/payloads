/*
 * inline_debugger.s - Displays register state by converting a register value into a hexadecimal string.
 *
 * Category: User‑Mode Demo
 *
 * This program sets x0 to a test value, converts it to hexadecimal,
 * and prints a debug message along with the converted value.
 */
    .section .data
debug_message:
    .asciz "Debugger: x0 = "
    .section .bss
    .lcomm hex_buffer, 18   // Buffer for 16 hex digits + newline.
    .section .text
    .global main
main:
    // Set test value in x0.
    mov x0, 0xDEADBEEFDEADBEEF

    // Convert number in x0 to hex string.
    bl num_to_hex

    // Write debug message.
    mov x0, 1           // stdout.
    adr x1, debug_message
    mov x2, #15         // 15 bytes.
    mov x8, 64          // syscall: write.
    svc 0

    // Write hexadecimal string.
    mov x0, 1           // stdout.
    adr x1, hex_buffer
    mov x2, #17         // 16 digits + newline.
    mov x8, 64          // syscall: write.
    svc 0

    // Exit.
    mov x0, 0
    mov x8, 93          // syscall: exit.
    svc 0

// Subroutine: num_to_hex
// Converts the 64-bit number in x0 into a hexadecimal string stored in hex_buffer.
num_to_hex:
    mov x6, x0
    mov x7, #16
    mov x8, #60        // 15*4 = 60.
    mov x4, #0
num_to_hex_loop:
    lsr x9, x6, x8
    and x9, x9, #0xF
    cmp x9, #10
    blt less_than_ten
    add x9, x9, #55    // 10->'A'
    b store_digit
less_than_ten:
    add x9, x9, #48    // 0->'0'
store_digit:
    adr x10, hex_buffer
    add x10, x10, x4
    strb w9, [x10]
    add x4, x4, #1
    subs x7, x7, #1
    sub x8, x8, #4
    b.ne num_to_hex_loop
    adr x10, hex_buffer
    add x10, x10, x4
    mov w11, #10      // newline.
    strb w11, [x10]
    ret
