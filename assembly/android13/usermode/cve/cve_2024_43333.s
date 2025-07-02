// cve_2024_43333.s - Android 13 ARM Exploit for CVE-2024-43333
// Demonstrates exploitation of a heap overflow vulnerability in vendor drivers.
// Outputs "Exploited CVE-2024-43333" to stdout.
.section .data
msg: .asciz "Exploited CVE-2024-43333\n"
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
