// cve_2024_50000.s - Kernelmode CVE: Privilege escalation via credential overwrite.
.section .data
msg: .asciz "Exploited CVE-2024-50000: Kernel privilege escalation.\n"
.section .text
.global _start
_start:
    mov x0, #1                     // stdout
    ldr x1, =msg
    mov x2, #52                    // length of message
    mov x8, #64                    // sys_write for AArch64 Linux
    svc #0
    mov x0, #0                     // exit code 0
    mov x8, #93                    // sys_exit
    svc #0
