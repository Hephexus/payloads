/*
 * kernel_chained_payload_executor.s - Kernel Chained Payload Executor
 *
 * This module simulates a scenario in which two small payloads are chained in the kernel.
 * It sequentially logs messages for Stage 1 and Stage 2 to demonstrate chaining.
 */
.extern printk
.section .data
kstage1:
    .asciz "Kernel Payload Stage 1 executed\n"
kstage2:
    .asciz "Kernel Payload Stage 2 executed\n"

.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =kstage1
    bl printk
    ldr x0, =kstage2
    bl printk
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kchain_msg_exit
    bl printk
    ret
.section .rodata
kchain_msg_exit:
    .asciz "Kernel Chained Payload Executor deactivated\n"
