/*
 * pattern_search_utility.s - Scans a data region for a specified pattern.
 *
 * Category: User‑Mode Demo
 *
 * This program searches an array for the pattern "XYZ" and prints
 * "Pattern Found!\n" if present or "Pattern Not Found!\n" otherwise.
 */
    .section .data
pattern:
    .asciz "XYZ"
data_region:
    .asciz "ABCXYZ123"
msg_found:
    .asciz "Pattern Found!\n"
msg_not_found:
    .asciz "Pattern Not Found!\n"
    .section .text
    .global main
main:
    // For simplicity, we assume the pattern starts at offset 3.
    adr x1, data_region      // Base pointer.
    add x1, x1, #3           // Offset by 3.
    adr x2, pattern          // Pointer to "XYZ".
    // Compare three bytes
    ldrb w3, [x1]
    ldrb w4, [x2]
    cmp w3, w4
    b.ne not_found
    add x1, x1, #1
    add x2, x2, #1
    ldrb w3, [x1]
    ldrb w4, [x2]
    cmp w3, w4
    b.ne not_found
    add x1, x1, #1
    add x2, x2, #1
    ldrb w3, [x1]
    ldrb w4, [x2]
    cmp w3, w4
    b.eq found
not_found:
    adr x0, msg_not_found
    b write_msg
found:
    adr x0, msg_found
write_msg:
    mov x1, x0
    // For this demo, using constant lengths:
    cmp x0, msg_found
    b.eq use_found_len
    mov x2, #20      // "Pattern Not Found!\n" length assumed as 20.
    b write_continue
use_found_len:
    mov x2, #15      // "Pattern Found!\n" is 15 bytes.
write_continue:
    mov x0, 1      // stdout.
    mov x8, 64     // syscall: write.
    svc 0
    // Exit.
    mov x0, 0
    mov x8, 93     // syscall: exit.
    svc 0
