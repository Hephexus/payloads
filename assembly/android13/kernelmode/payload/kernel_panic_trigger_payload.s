/*
 * kernel_panic_trigger_payload.s - Kernel Panic Trigger Payload.
 *
 * WARNING: This module actually triggers a kernel panic by calling panic().
 * Use ONLY in your isolated test environment.
 */
.extern printk
.extern panic
.section .text
.global init_module
.global cleanup_module
init_module:
    // Trigger a kernel panic by calling panic() with our message.
    ldr x0, =panic_msg
    bl panic             // This call should trigger a kernel panic.
    // If panic returns (unexpectedly), return 0.
    mov x0, 0
    ret
cleanup_module:
    // Cleanup is unlikely to be reached if panic is triggered.
    ldr x0, =panic_recover_msg
    bl printk
    ret
.section .rodata
panic_msg:
    .asciz "Kernel Panic Trigger Payload Activated - Initiating Panic!\n"
panic_recover_msg:
    .asciz "Kernel Panic Trigger Payload Deactivated\n"
