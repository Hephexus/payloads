/*
 * kernel_hardware_breakpoint_sleuth.s - Kernel Hardware Breakpoint Sleuth
 *
 * Fully functional version: This module uses the privileged MRS instruction to read
 * the debug register dbgbcr0_el1. If the register is nonzero, it suggests that hardware breakpoints
 * may be active. The result is logged via printk.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    /* Read DBGBCR0_EL1 */
    mrs x0, dbgbcr0_el1
    cmp x0, #0
    bne hb_debug_detected
    ldr x0, =kbhs_no_debug_msg
    bl printk
    b exit_hb
hb_debug_detected:
    ldr x0, =kbhs_debug_msg
    bl printk
exit_hb:
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kbhs_cleanup_msg
    bl printk
    ret
.section .rodata
kbhs_debug_msg:
    .asciz "Kernel Hardware Breakpoint Sleuth: Debug breakpoints detected\n"
kbhs_no_debug_msg:
    .asciz "Kernel Hardware Breakpoint Sleuth: No debug breakpoints detected\n"
kbhs_cleanup_msg:
    .asciz "Kernel Hardware Breakpoint Sleuth deactivated\n"
