/*
 * hello_world.s - User‑mode Hello World using syscalls for demonstration purposes.
 *
 * Category: User‑Mode Demo
 *
 * This program writes "Hello, World!\n" to stdout and exits.
 */
    .section .data
msg:
    .asciz "Hello, World!\n"
    .section .text
    .global main
main:
    // Write the message to stdout.
    mov x0, 1              // file descriptor 1: stdout
    adr x1, msg            // address of the message
    mov x2, 14             // message length ("Hello, World!\n" is 14 bytes)
    mov x8, 64             // syscall: write
    svc 0

    // Exit the program.
    mov x0, 0              // exit code 0
    mov x8, 93             // syscall: exit
    svc 0
