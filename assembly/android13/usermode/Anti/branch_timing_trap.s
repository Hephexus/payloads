/*
 * branch_timing_trap.s - Branch Timing Trap
 *
 * This module uses a brief branch-and-measure loop to check if instruction timing
 * is unusually delayed (which might indicate debugger single-stepping).
 */
 
.section .data
msg_debugger:
    .asciz "Debugger Detected (Branch Timing)\n"
msg_no_debugger:
    .asciz "No Debugger Detected (Branch Timing)\n"

.section .text
.global main
main:
    mrs x0, cntpct_el0
    mov x1, x0
    mov w2, #5000
bt_loop:
    subs w2, w2, #1
    bne bt_loop
    mrs x3, cntpct_el0
    sub x4, x3, x1
    mov x5, #80000     /* Threshold value */
    cmp x4, x5
    bgt debugger_found_bt
    mov x0, #1
    adr x1, msg_no_debugger
    mov x2, #38
    mov x8, #64
    svc 0
    b exit_bt
debugger_found_bt:
    mov x0, #1
    adr x1, msg_debugger
    mov x2, #37
    mov x8, #64
    svc 0
exit_bt:
    mov x0, #0
    mov x8, #93
    svc 0
