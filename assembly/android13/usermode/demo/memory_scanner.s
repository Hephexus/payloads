/*
 * memory_scanner.s - Scans a designated memory region for a specific 4-byte pattern.
 *
 * Category: User‑Mode Demo
 *
 * This program scans a memory region for the pattern "ABCD" (0x41, 0x42, 0x43, 0x44).
 * It prints "Pattern found!\n" if found, otherwise "Pattern not found!\n".
 */
    .section .data
message_found:
    .asciz "Pattern found!\n"
message_not_found:
    .asciz "Pattern not found!\n"
pattern:
    .byte 0x41, 0x42, 0x43, 0x44   // "ABCD"
data_region:
    // 20-byte region with the pattern embedded.
    .byte 0x00,0x11,0x22,0x33,0x41,0x42,0x43,0x44,0x55,0x66,
          0x77,0x88,0x99,0xAA,0xBB,0xCC,0xDD,0xEE,0xFF,0x00
    .equ DATA_REGION_LEN, 20
    .section .text
    .global main
main:
    adr x2, pattern       // Pointer to pattern.
    ldr w3, [x2]          // Load 4-byte pattern.

    mov x4, #0            // Current index.
    mov x5, #16           // Max index (20-4).

scan_loop:
    adr x6, data_region   // Base pointer.
    add x7, x6, x4        // Current data pointer.
    ldr w8, [x7]          // Load 4 bytes.
    cmp w8, w3
    beq pattern_found_label
    add x4, x4, #1
    cmp x4, x5
    ble scan_loop

    adr x1, message_not_found
    b scanner_done

pattern_found_label:
    adr x1, message_found

scanner_done:
    mov x0, 1            // stdout.
    // Determine message length.
    adr x9, message_found
    cmp x1, x9
    beq msg_found_length
    mov x2, #19         // "Pattern not found!\n" length.
    b do_write
msg_found_length:
    mov x2, #15         // "Pattern found!\n" length.
do_write:
    mov x8, 64          // syscall: write.
    svc 0

    mov x0, 0           // Exit.
    mov x8, 93
    svc 0
