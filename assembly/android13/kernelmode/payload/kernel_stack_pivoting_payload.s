/*
 * kernel_stack_pivoting_payload.s - Kernel Stack Pivoting Payload.
 *
 * This module demonstrates a controlled kernel-level stack pivot.
 * It saves the original stack pointer, sets a new stack pointer using a pre-allocated region,
 * performs a dummy operation, then restores the original stack pointer.
 *
 * WARNING: Manipulating the kernel stack pointer is highly dangerous.
 * Use ONLY in your contained test kernel.
 */
.extern printk
.section .bss
    .lcomm saved_sp, 8
    .lcomm pivot_stack, 256   // Allocate 256 bytes for the new stack.
.section .text
.global init_module
.global cleanup_module
init_module:
    // Save current stack pointer.
    mov x0, sp
    adr x1, saved_sp
    str x0, [x1]
    // Set new stack pointer (top of pivot_stack).
    adr x0, pivot_stack
    add x0, x0, #256
    mov sp, x0
    // Dummy operation.
    nop
    ldr x0, =pivot_msg_activated
    bl printk
    ret
cleanup_module:
    // Restore original stack pointer.
    adr x0, saved_sp
    ldr x0, [x0]
    mov sp, x0
    ldr x0, =pivot_msg_deactivated
    bl printk
    ret
.section .rodata
pivot_msg_activated:
    .asciz "Kernel Payload: Stack Pivoting Payload Activated\n"
pivot_msg_deactivated:
    .asciz "Kernel Payload: Stack Pivoting Payload Deactivated\n"
