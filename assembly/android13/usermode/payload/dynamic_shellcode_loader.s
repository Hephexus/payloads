/*
 * dynamic_shellcode_loader.s - Loads and executes shellcode from a buffer.
 *
 * Category: User‑Mode Payload
 *
 * This program prints "Loader starting..." then jumps to embedded shellcode which
 * prints "Shellcode executed!" and exits.
 */
    .section .data
msg_loader:
    .asciz "Loader starting...\n"
msg_sc:
    .asciz "Shellcode executed!\n"
    .section .text
    .global main
main:
    // Print loader message.
    mov x0, 1
    adr x1, msg_loader
    mov x2, #19           // "Loader starting...\n" is 19 bytes.
    mov x8, 64           // syscall: write.
    svc 0
    // Jump to shellcode.
    adr x0, shellcode
    br x0

shellcode:
    // Print shellcode executed message.
    mov x0, 1
    adr x1, msg_sc
    mov x2, #20           // "Shellcode executed!\n" is 20 bytes.
    mov x8, 64           // syscall: write.
    svc 0
    // Exit.
    mov x0, 0
    mov x8, 93           // syscall: exit.
    svc 0
