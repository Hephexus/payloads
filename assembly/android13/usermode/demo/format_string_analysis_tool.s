/*
 * format_string_analysis_tool.s - Analyzes a string for the presence of format specifiers.
 *
 * Category: User‑Mode Demo
 *
 * This program examines a hardcoded string for the '%' character.
 * If found, it prints "Format Specifier Detected\n", else "No Format Specifier\n".
 */
.section .data
test_str:
    .asciz "Test % string"
msg_detected:
    .asciz "Format Specifier Detected\n"
msg_not_detected:
    .asciz "No Format Specifier\n"
.section .text
.global main
main:
    adr x1, test_str     // Pointer to the test string.
    mov x2, #0           // Flag: 0 = not found.
check_loop:
    ldrb w3, [x1], #1
    cbz w3, decide
    cmp w3, #'%'
    beq found
    b check_loop
found:
    mov x2, #1
decide:
    cmp x2, #1
    beq print_detected
    adr x0, msg_not_detected
    b write_msg
print_detected:
    adr x0, msg_detected
write_msg:
    mov x1, x0
    cmp x0, msg_detected
    b.eq use_detected_len
    mov x2, #20   // Assume "No Format Specifier\n" is 20 bytes.
    b continue_write
use_detected_len:
    mov x2, #27   // Assume "Format Specifier Detected\n" is 27 bytes.
continue_write:
    mov x0, 1     // stdout.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
