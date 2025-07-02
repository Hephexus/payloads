/*
 * dma_controller_fuzzer.s - Kernel DMA Controller Fuzzer.
 *
 * This module writes iteration-dependent values into a dummy DMA buffer.
 */
.extern printk
.section .bss
    .lcomm dma_buf, 256
.section .text
.global init_module
.global cleanup_module
init_module:
    mov w0, #0
dma_loop:
    adr x1, dma_buf
    add x1, x1, x0
    mov w2, w0
    strb w2, [x1]
    add w0, w0, #1
    cmp w0, #256
    blt dma_loop
    ldr x0, =dma_msg
    bl printk
    ret
cleanup_module:
    ldr x0, =dma_msg_deactivated
    bl printk
    ret
.section .rodata
dma_msg:
    .asciz "Kernel DMA Controller Fuzzer executed\n"
dma_msg_deactivated:
    .asciz "Kernel DMA Controller Fuzzer deactivated\n"
