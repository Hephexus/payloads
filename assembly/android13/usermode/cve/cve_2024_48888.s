// cve_2024_48888.s - Android 13 ARM Exploit for CVE-2024-48888
// Exploits insecure file permissions to read sensitive data.
// Outputs "Exploited CVE-2024-48888" to stdout.
.section .data
msg: .asciz "Exploited CVE-2024-48888\n"
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
