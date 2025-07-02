/*
 * netlink_interface_fuzzer.s - Netlink Interface Fuzzer.
 *
 * This kernel module simulates sending netlink messages with varied parameters.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    mov w0, #1
netlink_loop:
    ldr x0, =knl_msg
    bl printk
    add w0, w0, #1
    cmp w0, #3
    blt netlink_loop
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =knl_msg_deactivated
    bl printk
    ret
.section .rodata
knl_msg:
    .asciz "Kernel Netlink Fuzzer iteration executed\n"
knl_msg_deactivated:
    .asciz "Kernel Netlink Fuzzer deactivated\n"
