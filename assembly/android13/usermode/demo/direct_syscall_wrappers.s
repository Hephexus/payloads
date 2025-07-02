/*
 * direct_syscall_wrappers.s - Demonstrates direct syscall wrapper usage.
 *
 * Category: User‑Mode Demo
 *
 * This program defines a simple wrapper for the write syscall and uses it to
 * print "Direct Syscall Wrappers Demo\n" to stdout.
 */
.section .data
msg_ds:
    .asciz "Direct Syscall Wrappers Demo\n"
.section .text
.global my_write
my_write:
    // x0 = file descriptor, x1 = buffer pointer, x2 = count.
    mov x8, 64      // syscall: write
    svc 0
    ret

.global main
main:
    mov x0, 1       // stdout
    adr x1, msg_ds
    mov x2, #28     // length of message ("Direct Syscall Wrappers Demo\n")
    bl my_write
    mov x0, 0
    mov x8, 93     // syscall: exit
    svc 0
