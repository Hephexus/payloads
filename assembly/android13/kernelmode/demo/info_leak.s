// info_leak.s - Android 13 ARM Information Leak Demo
// This shellcode reads 64 bytes from a fixed memory address and writes them to stdout.
.global _start
.section .text
_start:
    mov x0, #1             // stdout file descriptor
    ldr x1, =leak_addr     // address to leak from (example address)
    mov x2, #64            // number of bytes to leak
    mov x8, #64            // sys_write on AArch64 is 64
    svc #0
    mov x0, #0
    mov x8, #93            // sys_exit = 93
    svc #0
.section .data
leak_addr:
    .quad 0x400000         // Example address; adjust as needed for your target.
