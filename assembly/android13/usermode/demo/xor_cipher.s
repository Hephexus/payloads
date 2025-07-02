/*
 * xor_cipher.s - Implements a simple XOR-based encryption and decryption routine.
 *
 * Category: User‑Mode Demo
 *
 * This program encrypts a string using XOR with a constant key (0x55)
 * and prints the encrypted string to stdout.
 */
    .section .data
orig_string:
    .asciz "Secret Message\n"
    .section .bss
    .lcomm buffer, 64      // Reserve 64 bytes for the output buffer.
    .section .text
    .global main
main:
    // Set up pointers.
    adr x1, orig_string     // Input string pointer.
    adr x2, buffer          // Output buffer pointer.
    mov x4, x2              // Save the start of the output buffer.

xor_loop:
    ldrb w3, [x1], #1       // Load a byte and post-increment x1.
    cbz w3, xor_done        // If byte is zero, branch to done.
    eor w3, w3, #0x55       // XOR the byte with key 0x55.
    strb w3, [x2], #1       // Store result and post-increment x2.
    b xor_loop

xor_done:
    // Calculate encrypted string length.
    sub x5, x2, x4          // Length = current pointer - start pointer.

    // Write the encrypted string.
    mov x0, 1               // stdout.
    mov x1, x4              // Buffer start.
    mov x2, x5              // Length.
    mov x8, 64             // syscall: write.
    svc 0

    // Exit.
    mov x0, 0
    mov x8, 93             // syscall: exit.
    svc 0
