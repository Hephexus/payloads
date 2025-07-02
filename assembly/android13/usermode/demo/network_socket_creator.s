/*
 * network_socket_creator.s - Creates a network socket using syscalls.
 *
 * Category: User‑Mode Demo
 *
 * This program creates an AF_INET (2), SOCK_STREAM (1) socket and prints its file descriptor in hexadecimal.
 */
.section .data
msg_socket:
    .asciz "Socket FD: "
.section .bss
    .lcomm sock_hex, 18
.section .text
.global main
main:
    mov x0, #2       // AF_INET.
    mov x1, #1       // SOCK_STREAM.
    mov x2, #0       // Protocol 0.
    mov x8, 198      // syscall: socket.
    svc 0          // returns FD in x0.
    // Convert FD in x0 to hex.
    mov x3, x0     // save FD.
    bl num_to_hex_socket
    // Print the result.
    mov x0, 1     // stdout.
    adr x1, msg_socket
    mov x2, #11   // "Socket FD: " is 11 bytes.
    mov x8, 64
    svc 0
    mov x0, 1
    adr x1, sock_hex
    mov x2, #17   // hex string (16 digits + newline).
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0

num_to_hex_socket:
    // Convert the 32-bit FD (x3) to an 8-digit hex string in "sock_hex".
    mov x6, x3
    mov x7, #8           // Use 8 hex digits.
    mov x8, #28          // Starting shift: (8-1)*4 = 28.
    mov x4, #0           // Buffer index.
num_to_hex_loop_socket:
    lsr x9, x6, x8
    and x9, x9, #0xF
    cmp x9, #10
    blt less_than_ten_socket
    add x9, x9, #55
    b store_digit_socket
less_than_ten_socket:
    add x9, x9, #48
store_digit_socket:
    adr x10, sock_hex
    add x10, x10, x4
    strb w9, [x10]
    add x4, x4, #1
    subs x7, x7, #1
    sub x8, x8, #4
    b.ne num_to_hex_loop_socket
    adr x10, sock_hex
    add x10, x10, x4
    mov w11, #10
    strb w11, [x10]
    ret
