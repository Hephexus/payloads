/*
 * ptrace_detection.s - Ptrace Debugger Detection
 *
 * This module calls ptrace(PTRACE_TRACEME, 0, NULL, NULL) (syscall number 101 on ARM64).
 * If the call returns a negative value, it indicates that the process is already being traced.
 * The program writes "Debugger Detected" if so, else "No Debugger Detected", then exits.
 */
 
.section .data
msg_debugger:
    .asciz "Debugger Detected\n"
msg_nodebug:
    .asciz "No Debugger Detected\n"

.section .text
.global main
main:
    /* Call ptrace(PTRACE_TRACEME, 0, 0, 0) */
    mov x0, #0          /* PTRACE_TRACEME value is 0 */
    mov x1, 0
    mov x2, 0
    mov x3, 0
    mov x8, #101        /* ptrace syscall on ARM64 */
    svc 0
    /* Check return value in x0 (>= 0 means no debugger, negative means debugger attach) */
    cmp x0, #0
    bge no_debugger
debugger_found:
    mov x0, #1
    adr x1, msg_debugger
    mov x2, #18         /* 18 bytes (including newline) */
    mov x8, #64         /* write syscall */
    svc 0
    b exit_prog
no_debugger:
    mov x0, #1
    adr x1, msg_nodebug
    mov x2, #19         /* 19 bytes */
    mov x8, #64
    svc 0
exit_prog:
    mov x0, #0
    mov x8, #93         /* exit syscall */
    svc 0
