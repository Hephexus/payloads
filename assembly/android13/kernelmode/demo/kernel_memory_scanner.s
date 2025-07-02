/*
 * kernel_memory_scanner.s - Kernel Memory Scanner Demo.
 *
 * Category: Kernel Mode Demo
 *
 * Simulates scanning kernel memory by printing a message.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_memscan
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ret
.section .rodata
msg_memscan:
    .asciz "Kernel Module: Kernel Memory Scanner Demo\n"
