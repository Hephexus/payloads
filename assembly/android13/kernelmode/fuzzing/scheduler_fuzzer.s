/*
 * scheduler_fuzzer.s - Kernel Scheduler Fuzzer.
 *
 * This module simulates invoking scheduler modifications by logging a scheduler fuzzer message.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =sched_msg
    bl printk
    ret
cleanup_module:
    ldr x0, =sched_msg_deactivated
    bl printk
    ret
.section .rodata
sched_msg:
    .asciz "Kernel Scheduler Fuzzer executed\n"
sched_msg_deactivated:
    .asciz "Kernel Scheduler Fuzzer deactivated\n"
