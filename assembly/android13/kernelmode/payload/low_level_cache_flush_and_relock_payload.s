/*
 * low_level_cache_flush_and_relock_payload.s - Low-Level Cache Flush and Relock Payload.
 *
 * Category: Kernel Mode Payload
 *
 * This module flushes CPU caches and then re-establishes cache coherency.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_cache_flush_activated
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_cache_flush_deactivated
    bl printk
    ret
.section .rodata
msg_cache_flush_activated:
    .asciz "Kernel Payload: Cache Flush and Relock Activated\n"
msg_cache_flush_deactivated:
    .asciz "Kernel Payload: Cache Flush and Relock Deactivated\n"
