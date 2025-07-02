/*
 * kernel_timing_detector.s - Kernel Timing Detector
 *
 * Fully functional version: This module reads the system counter (cntpct_el0) using MRS,
 * delays for a loop, reads it again, and compares the elapsed cycles to a threshold to detect slowdowns.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    mrs x0, cntpct_el0
    mov x1, x0
    mov w2, #5000
kt_loop:
    subs w2, w2, #1
    bne kt_loop
    mrs x3, cntpct_el0
    sub x4, x3, x1
    mov x5, #80000       /* Set threshold */
    cmp x4, x5
    bgt debugger_detected_kt
    ldr x0, =kt_no_debug_msg
    bl printk
    b exit_kt
debugger_detected_kt:
    ldr x0, =kt_debug_msg
    bl printk
exit_kt:
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kt_cleanup_msg
    bl printk
    ret
.section .rodata
kt_debug_msg:
    .asciz "Kernel Timing Detector: Debugger detected\n"
kt_no_debug_msg:
    .asciz "Kernel Timing Detector: No debugger detected\n"
kt_cleanup_msg:
    .asciz "Kernel Timing Detector deactivated\n"
