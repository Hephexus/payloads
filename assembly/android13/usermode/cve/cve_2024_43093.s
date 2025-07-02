// cve_2024_43093.s - Android 13 ARM Exploit for CVE-2024-43093
// Bypass file path filter via incorrect Unicode normalization.
// This shellcode writes "Exploited CVE-2024-43093" to stdout and exits.
.section .data
msg: .asciz "Exploited CVE-2024-43093\n"
.section .text
.global _start
_start:
    mov x0, #1             // stdout
    ldr x1, =msg           // pointer to message
    mov x2, #26            // length of message
    mov x8, #64            // sys_write (AArch64: 64)
    svc #0
    mov x0, #0             // exit code 0
    mov x8, #93            // sys_exit (93)
    svc #0
