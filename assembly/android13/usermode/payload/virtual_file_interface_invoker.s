/*
 * virtual_file_interface_invoker.s - Virtual File Interface Invoker Payload.
 *
 * This payload demonstrates opening a virtual file interface (simulated)
 * and prints "Virtual File Interface Invoker Executed\n".
 */
.section .data
msg:
    .asciz "Virtual File Interface Invoker Executed\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg
    mov x2, #47        // 47 bytes message.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
