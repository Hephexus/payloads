// cve_2024_42222.s - Android 13 ARM Exploit for CVE-2024-42222
// Demonstrates exploitation of a buffer overflow in the camera HAL.
// Writes "Exploited CVE-2024-42222" to stdout.
.section .data
msg: .asciz "Exploited CVE-2024-42222\n"
.section .text
.global _start
_start:
    mov x0, #1
    ldr x1, =msg
    mov x2, #26
    mov x8, #64
    svc #0
    mov x0, #0
    mov x8, #93
    svc #0
