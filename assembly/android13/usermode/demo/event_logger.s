/*
 * event_logger.s - Event Logger Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program prints a demo event message.
 */
.section .data
event_msg:
    .asciz "Event: Demo Event at 123456\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, event_msg
    mov x2, #27             // message length (approx.)
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
