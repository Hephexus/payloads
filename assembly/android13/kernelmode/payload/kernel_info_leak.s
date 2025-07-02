// kernel_info_leak.s - Kernel Information Leak Payload (Kernelmode)
// Simulates an info leak by printing a message.
.global _start
.section .text
_start:
    mov x0, #1
    ldr x1, =msg
    mov x2, #27
    mov x8, #64
    svc #0
    mov x0, #0
    mov x8, #93
    svc #0
.section .data
msg: .asciz "Kernel info leak exploited!\n"
