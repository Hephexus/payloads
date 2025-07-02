; Android 13 ARM Open, Read, Write Shellcode
.section .data
filename: .asciz "/data/local/tmp/test.txt"
.section .text
.global _start
_start:
    /* Open the file (O_RDONLY, mode=0) */
    ldr x0, =filename   @ pointer to filename
    mov x1, #0          @ O_RDONLY
    mov x2, #0          @ mode (not used for read-only)
    mov x8, #5          @ sys_open (5 on ARM)
    svc 0
    mov x4, x0          @ store file descriptor in x4

    /* Allocate buffer on stack (128 bytes) */
    sub sp, sp, #128

    /* Read up to 100 bytes from the file */
    mov x0, x4          @ file descriptor
    mov x1, sp          @ buffer pointer
    mov x2, #100        @ number of bytes
    mov x8, #3          @ sys_read (3 on ARM)
    svc 0
    mov x5, x0          @ number of bytes read

    /* Write the contents to stdout (fd 1) */
    mov x0, #1          @ stdout
    mov x1, sp          @ buffer pointer
    mov x2, x5          @ number of bytes read
    mov x8, #4          @ sys_write (4 on ARM)
    svc 0

    /* Close the file descriptor */
    mov x0, x4
    mov x8, #6          @ sys_close (6 on ARM)
    svc 0

    /* Exit */
    mov x0, #0
    mov x8, #93
    svc 0