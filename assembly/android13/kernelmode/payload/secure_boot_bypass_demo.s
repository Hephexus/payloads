/*
 * secure_boot_bypass_demo.s - Secure Boot Bypass Demo Payload.
 *
 * This module simulates bypassing secure boot by modifying a dummy secure boot flag.
 * It sets the flag to 0 on activation and restores it to 1 on cleanup.
 */
.extern printk
.section .bss
    .lcomm secure_boot_flag, 4
.section .text
.global init_module
.global cleanup_module
init_module:
    // Simulate bypass by setting secure_boot_flag = 0.
    mov w0, #0
    adr x1, secure_boot_flag
    str w0, [x1]
    ldr x0, =secboot_msg_activated
    bl printk
    ret
cleanup_module:
    // Restore secure boot flag to 1.
    mov w0, #1
    adr x1, secure_boot_flag
    str w0, [x1]
    ldr x0, =secboot_msg_deactivated
    bl printk
    ret
.section .rodata
secboot_msg_activated:
    .asciz "Secure Boot Bypass Demo Activated\n"
secboot_msg_deactivated:
    .asciz "Secure Boot Bypass Demo Deactivated\n"
