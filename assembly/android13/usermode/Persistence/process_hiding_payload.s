/*
 * process_hiding_payload.s - Process Hiding Payload
 *
 * This module uses the prctl syscall to change the process name,
 * effectively hiding its true identity from standard tools.
 *
 * Syscall used: prctl (157)
 *
 * This demonstration sets the process name to "hidden".
 */
 
.section .data
new_name:
    .asciz "hidden\0"
msg_prctl:
    .asciz "Process Hiding: Name set to 'hidden'\n"

.section .text
.global main
main:
    ; prctl(PR_SET_NAME, new_name, 0, 0, 0)
    mov x0, #15          /* PR_SET_NAME is 15 on Linux */
    adr x1, new_name
    mov x2, #0
    mov x3, #0
    mov x4, #0
    mov x8, #157         /* prctl syscall */
    svc 0
    ; Report success via write
    mov x0, #1
    adr x1, msg_prctl
    mov x2, #39
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0
