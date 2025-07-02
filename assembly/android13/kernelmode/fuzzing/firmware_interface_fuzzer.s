/*
 * firmware_interface_fuzzer.s - Kernel Firmware Interface Fuzzer.
 *
 * This module simulates sending a sequence of commands to a firmware interface.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =fw_msg
    bl printk
    ret
cleanup_module:
    ldr x0, =fw_msg_deactivated
    bl printk
    ret
.section .rodata
fw_msg:
    .asciz "Kernel Firmware Interface Fuzzer executed\n"
fw_msg_deactivated:
    .asciz "Kernel Firmware Interface Fuzzer deactivated\n"
