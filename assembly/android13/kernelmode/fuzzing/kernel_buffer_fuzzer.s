/*
 * kernel_buffer_fuzzer.s - Kernel Buffer Fuzzer.
 *
 * This module simulates allocation of kernel memory and writes pseudo-random data into it.
 */
.extern printk
.section .bss
    .lcomm kbuf, 128
.section .text
.global init_module
.global cleanup_module
init_module:
    mov w0, #0
kb_loop:
    adr x1, kbuf
    add x1, x1, x0
    mov w2, w0
    strb w2, [x1]
    add w0, w0, #1
    cmp w0, #128
    blt kb_loop
    ldr x0, =kbuf_msg
    bl printk
    ret
cleanup_module:
    ldr x0, =kbuf_msg_deactivated
    bl printk
    ret
.section .rodata
kbuf_msg:
    .asciz "Kernel Buffer Fuzzer executed\n"
kbuf_msg_deactivated:
    .asciz "Kernel Buffer Fuzzer deactivated\n"
