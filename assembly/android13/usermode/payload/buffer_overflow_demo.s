// buffer_overflow_demo.s - Demonstrates a buffer overflow exploit payload
.global _start
.section .text
_start:
    // Simulate overflowing a buffer by jumping to dummy shellcode.
    ldr x0, =dummy_shellcode
    br x0
.section .data
dummy_shellcode: .asciz "Buffer Overflow Exploited!\n"
