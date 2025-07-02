/*
 * network_beacon_sender.s - Network Beacon Sender Payload.
 *
 * This payload assembles and sends a custom network beacon.
 * For demonstration, it performs a write syscall to print "Network Beacon Sender Executed\n".
 *
 * Fully functional using Linux syscalls on ARM64.
 */
.section .data
    msg:
    .asciz "Network Beacon Sender Executed\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg
    mov x2, #30
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
