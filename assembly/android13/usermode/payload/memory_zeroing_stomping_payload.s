/*
 * memory_zeroing_stomping_payload.s - Memory Zeroing/Stomping Payload.
 *
 * This payload overwrites a designated memory region with zeros.
 * It prints "Memory Zeroing/Stomping Payload Executed\n".
 */
.section .data
msg:
    .asciz "Memory Zeroing/Stomping Payload Executed\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg
    mov x2, #48        // 48 bytes message.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
