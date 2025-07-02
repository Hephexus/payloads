/*
 * anti_debugging_payload.s - Anti-Debugging Payload.
 *
 * This payload attempts to detect if it is being traced by invoking ptrace(PTRACE_TRACEME, ...).
 * If ptrace returns an error (indicating a debugger is present), it prints "Debugger Detected\n".
 * Otherwise, it prints "No Debugger Detected\n".
 */

.section .data
msg_no_debugger:
    .asciz "No Debugger Detected\n"
msg_debugger:
    .asciz "Debugger Detected\n"

.section .text
.global main
main:
    // Attempt to call ptrace(PTRACE_TRACEME, 0, 0, 0).
    // On Linux ARM64, the ptrace syscall number is 101.
    mov x0, 0              // PTRACE_TRACEME
    mov x1, 0
    mov x2, 0
    mov x3, 0
    mov x8, #101          // syscall: ptrace
    svc 0
    // If ptrace returns a negative value, assume a debugger is attached.
    cmp x0, #0
    blt debugger_found

no_debugger:
    mov x0, #1
    adr x1, msg_no_debugger
    mov x2, #21           // length
    mov x8, #64           // write
    svc 0
    b exit_clean

debugger_found:
    mov x0, #1
    adr x1, msg_debugger
    mov x2, #19           // length
    mov x8, #64           // write
    svc 0

exit_clean:
    mov x0, #0
    mov x8, #93           // exit syscall
    svc 0
