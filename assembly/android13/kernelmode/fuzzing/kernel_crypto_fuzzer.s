/*
 * kernel_crypto_fuzzer.s - Kernel Crypto Fuzzer.
 *
 * This module simulates fuzzing of the kernel crypto API using dummy key/data processing.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =kcrypto_msg
    bl printk
    ret
cleanup_module:
    ldr x0, =kcrypto_msg_deactivated
    bl printk
    ret
.section .rodata
kcrypto_msg:
    .asciz "Kernel Crypto Fuzzer executed\n"
kcrypto_msg_deactivated:
    .asciz "Kernel Crypto Fuzzer deactivated\n"
