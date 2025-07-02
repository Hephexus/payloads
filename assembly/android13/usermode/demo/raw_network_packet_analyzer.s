/*
 * raw_network_packet_analyzer.s - Simulates analysis of a raw network packet.
 *
 * Category: User‑Mode Demo
 *
 * This program prints "Packet Analyzed\n".
 */
    .section .data
packet_msg:
    .asciz "Packet Analyzed\n"
    .section .text
    .global main
main:
    mov x0, 1         // stdout.
    adr x1, packet_msg
    mov x2, #16       // Length of "Packet Analyzed\n" (16 bytes).
    mov x8, 64      // syscall: write.
    svc 0
    mov x0, 0
    mov x8, 93      // syscall: exit.
    svc 0
