/*
 * timing_based_anti_debug.s - Timing-Based Anti-Debug Detection
 *
 * This module reads the system counter via "mrs x0, cntpct_el0", runs a small loop,
 * then reads again to calculate the elapsed time. If the delta exceeds a threshold,
 * it assumes debugger interference.
 */
 
.section .data
msg_debugger:
    .asciz "Debugger Detected (Timing)\n"
msg_nodebug:
    .asciz "No Debugger Detected (Timing)\n"

.section .text
.global main
main:
    /* Read the system counter */
    mrs x0, cntpct_el0      /* x0 = start count */
    mov x1, x0              /* Save for later */
    /* Simple delay loop */
    mov w2, #10000
delay_loop:
    subs w2, w2, #1
    bne delay_loop
    /* Read counter again */
    mrs x3, cntpct_el0      /* x3 = end count */
    sub x4, x3, x1         /* x4 = elapsed cycles */
    /* Compare elapsed cycles with threshold (e.g., 100000) */
    mov x5, #100000
    cmp x4, x5
    bgt debugger_detected
no_debugger:
    mov x0, #1
    adr x1, msg_nodebug
    mov x2, #30         /* Length of message */
    mov x8, #64
    svc 0
    b exit_timing
debugger_detected:
    mov x0, #1
    adr x1, msg_debugger
    mov x2, #29
    mov x8, #64
    svc 0
exit_timing:
    mov x0, #0
    mov x8, #93
    svc 0
