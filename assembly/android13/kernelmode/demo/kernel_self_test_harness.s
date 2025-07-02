/*
 * kernel_self_test_harness.s - Kernel Self-Test Harness Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates running self-tests on kernel modules.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_self_test
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_self_test_cleanup
    bl printk
    ret
.section .rodata
msg_self_test:
    .asciz "Kernel Module: Self-Test Harness Activated\n"
msg_self_test_cleanup:
    .asciz "Kernel Module: Self-Test Harness Deactivated\n"
