/*
 * file_reader_writer_module.s - Demonstrates file reading and writing using syscalls.
 *
 * Category: User‑Mode Demo
 *
 * This program opens "/etc/hostname", reads up to 64 bytes, and writes them to stdout.
 */
.section .data
file_path:
    .asciz "/etc/hostname"
.section .bss
    .lcomm buffer, 64
.section .text
.global main
main:
    // Use openat syscall: openat(AT_FDCWD, file_path, O_RDONLY, 0)
    mov x0, #-100      // AT_FDCWD = -100.
    adr x1, file_path
    mov x2, #0         // O_RDONLY.
    mov x3, #0         // mode = 0.
    mov x8, 56         // syscall: openat.
    svc 0              // FD returned in x0.
    mov x10, x0        // Save file descriptor.
    // Read from file.
    mov x0, x10
    adr x1, buffer
    mov x2, #64
    mov x8, 63         // syscall: read.
    svc 0              // bytes read in x0.
    // Write buffer to stdout.
    mov x0, 1         // stdout.
    adr x1, buffer
    mov x2, x0        // number of bytes read.
    mov x8, 64
    svc 0
    // Close the file.
    mov x0, x10
    mov x8, 57         // syscall: close.
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
