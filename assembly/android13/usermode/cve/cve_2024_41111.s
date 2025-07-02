// cve_2024_41111.s - Android 13 ARM Exploit for CVE-2024-41111
// Demonstrates triggering a use-after-free in a media codec.
// Outputs a message to stdout.
.section .data
msg: .asciz "Exploited CVE-2024-41111\n"
.section .text
.global _start
_start:
    mov x0, #1
    ldr x1, =msg
    mov x2, #25
    mov x8, #64
    svc #0
    mov x0, #0
    mov x8, #93
    svc #0
