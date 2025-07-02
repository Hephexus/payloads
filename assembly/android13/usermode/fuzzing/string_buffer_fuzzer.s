/*
 * string_buffer_fuzzer.s - User-Mode String Buffer Fuzzer.
 *
 * This fuzzer simulates a memcpy-like operation by copying from a source buffer to a destination buffer
 * with differing lengths to stress-test memory copy routines.
 */
 
.section .data
src_buffer:
    .asciz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
dest_buffer:
    .space 32
msg_done:
    .asciz "String Buffer Fuzzer iteration complete\n"

.section .text
.global main
main:
    mov w0, #4          // Start copying 4 bytes
copy_iter:
    adr x2, dest_buffer   // Reset destination pointer
    adr x3, src_buffer    // Reset source pointer
    mov w4, w0           // Number of bytes to copy
copy_loop:
    cbz w4, copy_done
    ldrb w5, [x3], #1
    strb w5, [x2], #1
    subs w4, w4, #1
    bne copy_loop
copy_done:
    mov x0, #1
    adr x1, msg_done
    mov x2, #36
    mov x8, #64      // write syscall
    svc 0
    add w0, w0, #4   // Increase copy length
    cmp w0, #40
    blt copy_iter
    mov x0, #0
    mov x8, #93
    svc 0
