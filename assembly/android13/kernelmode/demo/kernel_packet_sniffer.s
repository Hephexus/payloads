/*
 * kernel_packet_sniffer.s - Kernel Packet Sniffer Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates capturing network packets at the kernel level.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_sniffer
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_sniffer_cleanup
    bl printk
    ret
.section .rodata
msg_sniffer:
    .asciz "Kernel Module: Packet Sniffer Activated\n"
msg_sniffer_cleanup:
    .asciz "Kernel Module: Packet Sniffer Deactivated\n"
