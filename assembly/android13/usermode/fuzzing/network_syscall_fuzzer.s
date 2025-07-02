/*
 * network_syscall_fuzzer.s - User-Mode Network Syscall Fuzzer.
 *
 * This fuzzer creates a socket using AF_INET and AF_INET6 domains, then attempts a dummy connect,
 * and logs the iteration.
 */
 
.section .data
msg_net:
    .asciz "Network Syscall Fuzzer iteration complete\n"
dummy_sock:
    .space 16

.section .text
.global main
main:
    mov w0, #2         // Start with AF_INET
net_loop:
    mov x1, #1         // SOCK_STREAM
    mov x2, #0         // protocol 0
    mov x8, #198       // socket syscall
    svc 0
    mov x3, x0       // Save socket FD in x3
    mov x0, x3
    adr x1, dummy_sock
    mov x2, #16
    mov x8, #203      // connect syscall
    svc 0
    mov x0, x3
    mov x8, #57     // close syscall
    svc 0
    mov x0, #1
    adr x1, msg_net
    mov x2, #37
    mov x8, #64
    svc 0
    cmp w0, #2
    beq set_inet6
    mov w0, #2
    b next_net
set_inet6:
    mov w0, #10
next_net:
    cmp w0, #10
    blt net_loop
    mov x0, #0
    mov x8, #93
    svc 0
