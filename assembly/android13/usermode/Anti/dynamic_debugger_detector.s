/*
 * dynamic_debugger_detector.s - Dynamic Debugger Detector
 *
 * This module combines the ptrace-based and timing-based detection mechanisms.
 * It first calls ptrace_detection, then performs a timing test, and outputs a message
 * indicating the overall result.
 */
 
.section .data
msg_debugger:
    .asciz "Debugger Detected (Dynamic)\n"
msg_no_debugger:
    .asciz "No Debugger Detected (Dynamic)\n"

.section .text
.global main
main:
    /* First, perform ptrace detection */
    mov x0, #0      /* PTRACE_TRACEME */
    mov x1, 0
    mov x2, 0
    mov x3, 0
    mov x8, #101    /* ptrace syscall */
    svc 0
    cmp x0, #0
    bge timing_check
    /* If ptrace returns negative, report debugger */
    mov x0, #1
    adr x1, msg_debugger
    mov x2, #29
    mov x8, #64
    svc 0
    b exit_dyn
timing_check:
    /* Use a small loop timing check */
    mrs x0, cntpct_el0
    mov x1, x0
    mov w2, #5000
dyn_loop:
    subs w2, w2, #1
    bne dyn_loop
    mrs x3, cntpct_el0
    sub x4, x3, x1
    mov x5, #80000
    cmp x4, x5
    bgt debugger_found_dyn
    mov x0, #1
    adr x1, msg_no_debugger
    mov x2, #31
    mov x8, #64
    svc 0
    b exit_dyn
debugger_found_dyn:
    mov x0, #1
    adr x1, msg_debugger
    mov x2, #29
    mov x8, #64
    svc 0
exit_dyn:
    mov x0, #0
    mov x8, #93
    svc 0
