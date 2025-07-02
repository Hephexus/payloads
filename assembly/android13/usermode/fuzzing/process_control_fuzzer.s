/*
 * process_control_fuzzer.s - User-Mode Process Control Fuzzer.
 *
 * This fuzzer uses vfork (syscall 57) to create short-lived child processes,
 * with the parent logging an iteration message.
 *
 * WARNING: Limit iterations to avoid process overload.
 */
 
.section .data
msg_proc:
    .asciz "Process Control Fuzzer iteration complete\n"

.section .text
.global main
main:
    mov w0, #0
proc_loop:
    mov x8, #57       // vfork
    svc 0
    cmp x0, #0
    beq child_branch
    mov x0, #1
    adr x1, msg_proc
    mov x2, #39
    mov x8, #64
    svc 0
    b continue_proc
child_branch:
    mov x0, #0
    mov x8, #93      // exit child
    svc 0
continue_proc:
    add w0, w0, #1
    cmp w0, #3
    blt proc_loop
    mov x0, #0
    mov x8, #93
    svc 0
