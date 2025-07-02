/*
 * interrupt_vector_fuzzer.s - Interrupt Vector Fuzzer.
 *
 * This module writes iteration-dependent values into a dummy memory region simulating the IDT.
 */
.extern printk
.section .bss
    .lcomm iv_table, 32
.section .text
.global init_module
.global cleanup_module
init_module:
    mov w0, #0
iv_loop:
    adr x1, iv_table
    add x1, x1, x0
    mov w2, w0
    strb w2, [x1]
    add w0, w0, #1
    cmp w0, #32
    blt iv_loop
    ldr x0, =iv_msg
    bl printk
    ret
cleanup_module:
    ldr x0, =iv_msg_deactivated
    bl printk
    ret
.section .rodata
iv_msg:
    .asciz "Kernel Interrupt Vector Fuzzer executed\n"
iv_msg_deactivated:
    .asciz "Kernel Interrupt Vector Fuzzer deactivated\n"
