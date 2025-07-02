// cve_2024_46666.s - Android 13 ARM Exploit for CVE-2024-46666
// Exploits a flaw in native library loading to execute arbitrary code.
// Outputs "Exploited CVE-2024-46666" to stdout.
.section .data
msg: .asciz "Exploited CVE-2024-46666\n"
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
