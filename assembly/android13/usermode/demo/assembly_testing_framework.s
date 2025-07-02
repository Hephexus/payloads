/*
 * assembly_testing_framework.s - Assembly Testing Framework Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program simulates an automated testing harness by printing
 * "All tests passed\n".
 */
.section .data
msg_tests:
    .asciz "All tests passed\n"
.section .text
.global main
main:
    mov x0, 1
    adr x1, msg_tests
    mov x2, #18     // Length of "All tests passed\n"
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
