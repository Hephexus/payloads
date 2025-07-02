/*
 * kernel_debugger_presence_trap.s - Kernel Debugger Presence Trap
 *
 * Fully functional version: This module sets up a trap by reading the system counter, executing a short branch,
 * and checking if the delay is abnormally long, indicating single-stepping. It logs the result.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    mrs x0, cntpct_el0
    mov x1, x0
    mov w2, #5000
    bdebug_loop:
        subs w2, w2, #1
        bne bdebug_loop
    mrs x3, cntpct_el0
    sub x4, x3, x1
    mov x5, #80000
    cmp x4, x5
    bgt kdpt_debug
    ldr x0, =kdpt_no_debug_msg
    bl printk
    b kdpt_end
kdpt_debug:
    ldr x0, =kdpt_debug_msg
    bl printk
kdpt_end:
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kdpt_cleanup_msg
    bl printk
    ret
.section .rodata
kdpt_debug_msg:
    .asciz "Kernel Debugger Presence Trap: Debugger detected\n"
kdpt_no_debug_msg:
    .asciz "Kernel Debugger Presence Trap: No debugger detected\n"
kdpt_cleanup_msg:
    .asciz "Kernel Debugger Presence Trap deactivated\n"
