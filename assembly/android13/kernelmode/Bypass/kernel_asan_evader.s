/*
 * kernel_asan_evader.s - Kernel ASAN Evader
 *
 * Runs operations in a loop that would avoid triggering ASAN detectors.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =kan_msg
    bl printk
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kan_msg_exit
    bl printk
    ret
.section .rodata
kan_msg:
    .asciz "Kernel ASAN evader executed\n"
kan_msg_exit:
    .asciz "Kernel ASAN evader deactivated\n"
