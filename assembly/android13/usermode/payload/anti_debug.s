// anti_debug.s - Anti-Debugging Payload for Android 13 (Usermode)
// In a realistic payload, system registers might be inspected to detect a debugger.
// Here, we simply print a message.
.global _start
.section .text
_start:
    mov x0, #1                     // stdout
    ldr x1, =msg
    mov x2, #36                    // message length
    mov x8, #64                    // sys_write for AArch64
    svc #0
    mov x0, #0
    mov x8, #93                    // sys_exit
    svc #0
.section .data
msg: .asciz "No debugger detected. Proceeding exploitation.\n"
