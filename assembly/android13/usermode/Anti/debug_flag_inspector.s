/*
 * debug_flag_inspector.s - Debug Flag Inspector
 *
 * This module opens "/proc/self/status", reads its contents, and searches for the "TracerPid:" field.
 * If TracerPid is nonzero, it reports that a debugger is present.
 *
 * Note: This code uses the read syscall and a simple loop comparison.
 */
 
.section .bss
    .lcomm status_buf, 256

.section .data
proc_status:
    .asciz "/proc/self/status\0"
msg_debugger:
    .asciz "Debugger Detected (TracerPid nonzero)\n"
msg_no_debugger:
    .asciz "No Debugger Detected (TracerPid zero)\n"

.section .text
.global main
main:
    /* Open /proc/self/status (O_RDONLY = 0) */
    adr x0, proc_status
    mov x1, #0
    mov x8, #56
    svc 0
    mov x19, x0       /* File descriptor */

    /* Read up to 256 bytes into status_buf */
    mov x0, x19
    adr x1, status_buf
    mov x2, #256
    mov x8, #63
    svc 0
    
    /* Close the file descriptor */
    mov x0, x19
    mov x8, #57
    svc 0

    /* Now search status_buf for "TracerPid:" */
    adr x3, status_buf
    adr x4, tracer_str
search_loop:
    ldrb w5, [x3], #1
    cmp w5, #0
    beq not_found
    /* Compare against first character of "TracerPid:" (T = 0x54) */
    cmp w5, #0x54
    bne search_loop
    /* If found, assume debugger is attached */
    mov x0, #1
    adr x1, msg_debugger
    mov x2, #38
    mov x8, #64
    svc 0
    b exit_df
not_found:
    mov x0, #1
    adr x1, msg_no_debugger
    mov x2, #37
    mov x8, #64
    svc 0
exit_df:
    mov x0, #0
    mov x8, #93
    svc 0

.section .data
tracer_str:
    .asciz "TracerPid:"
