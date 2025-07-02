/*
 * direct_interrupt_hijacker.s - Direct Interrupt Hijacker Payload.
 *
 * This module simulates accessing the Interrupt Descriptor Table (IDT).
 * It does not modify the IDT but uses a dummy value to represent the current IDT address.
 * The purpose is to demonstrate the concept of IDT hijacking.
 */
.extern printk
.section .bss
    .lcomm idt_storage, 10   // Reserve 10 bytes for a dummy IDT.
.section .text
.global init_module
.global cleanup_module
init_module:
    // Simulate reading the IDT.
    adr x0, idt_storage
    ldr x1, =dummy_idt_value
    str x1, [x0]         // Store the dummy IDT value.
    ldr x0, =idt_msg_activated
    bl printk
    ret
cleanup_module:
    ldr x0, =idt_msg_deactivated
    bl printk
    ret
.section .rodata
dummy_idt_value:
    .quad 0xDEADBEEFDEADBEEF   // Dummy IDT address.
idt_msg_activated:
    .asciz "Direct Interrupt Hijacker Activated: IDT value retrieved.\n"
idt_msg_deactivated:
    .asciz "Direct Interrupt Hijacker Deactivated.\n"
