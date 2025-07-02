// cve_2024_49000.s - Kernelmode CVE: Arbitrary write vulnerability.
.section .data
msg: .asciz "Exploited CVE-2024-49000: Arbitrary kernel write.\n"
.section .text
.global _start
_start:
    mov x0, #1                     // stdout
    ldr x1, =msg
    mov x2, #47                    // length of message
    mov x8, #64                    // sys_write for AArch64 Linux
    svc #0
    mov x0, #0                     // exit code 0
    mov x8, #93                    // sys_exit
    svc #0
