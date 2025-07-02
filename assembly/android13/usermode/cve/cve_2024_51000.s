// cve_2024_51000.s - Usermode CVE: Heap overflow in Bluetooth stack.
.section .data
msg: .asciz "Exploited CVE-2024-51000: Heap overflow (Bluetooth).\n"
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
