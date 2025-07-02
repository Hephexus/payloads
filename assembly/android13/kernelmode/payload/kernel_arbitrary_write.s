// kernel_arbitrary_write.s - Kernel Arbitrary Write Payload (Kernelmode)
// Simulates an arbitrary write by printing a confirmation message.
.global _start
.section .text
_start:
    mov x0, #1
    ldr x1, =msg
    mov x2, #33
    mov x8, #64
    svc #0
    mov x0, #0
    mov x8, #93
    svc #0
.section .data
msg: .asciz "Kernel arbitrary write exploited!\n"
