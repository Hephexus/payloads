/*
 * kernel_module_fuzzer.s - Kernel Module Fuzzer.
 *
 * This kernel module fuzzer repeatedly logs an iteration message to simulate module reloads.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    mov w0, #0
module_loop:
    ldr x0, =kmf_msg
    bl printk
    add w0, w0, #1
    cmp w0, #5
    blt module_loop
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kmf_msg_deactivated
    bl printk
    ret
.section .rodata
kmf_msg:
    .asciz "Kernel Module Fuzzer iteration executed\n"
kmf_msg_deactivated:
    .asciz "Kernel Module Fuzzer deactivated\n"
