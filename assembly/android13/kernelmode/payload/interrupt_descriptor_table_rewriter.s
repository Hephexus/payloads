/*
 * interrupt_descriptor_table_rewriter.s - IDT Rewriter Payload.
 *
 * Category: Kernel Mode Payload
 *
 * This module simulates rewriting the Interrupt Descriptor Table (IDT) to redirect interrupts.
 * It logs its activation and deactivation via printk.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_idt_rewriter_activated
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_idt_rewriter_deactivated
    bl printk
    ret
.section .rodata
msg_idt_rewriter_activated:
    .asciz "Kernel Payload: IDT Rewriter Activated\n"
msg_idt_rewriter_deactivated:
    .asciz "Kernel Payload: IDT Rewriter Deactivated\n"
