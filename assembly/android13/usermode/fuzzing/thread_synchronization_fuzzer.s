/*
 * thread_synchronization_fuzzer.s - User-Mode Thread Synchronization Fuzzer.
 *
 * This fuzzer uses the clone syscall to spawn a child thread and logs synchronization activity.
 *
 * WARNING: Limit iterations to prevent excessive thread creation.
 */
 
.section .data
msg_thread:
    .asciz "Thread Synchronization Fuzzer iteration complete\n"

.section .bss
    .lcomm child_stack, 512

.section .text
.global main
main:
    mov w0, #0
thread_loop:
    adr x1, child_stack
    add x1, x1, #512   // Set child stack pointer to top
    mov x0, #17        // SIGCHLD flag for clone
    mov x8, #220       // clone syscall
    svc 0
    cmp x0, #0
    beq child_branch
parent_branch:
    mov x0, #1
    adr x1, msg_thread
    mov x2, #48
    mov x8, #64
    svc 0
    b continue_thread
child_branch:
    mov x0, #0
    mov x8, #93       // Child exits immediately
    svc 0
continue_thread:
    add w0, w0, #1
    cmp w0, #3
    blt thread_loop
    mov x0, #0
    mov x8, #93
    svc 0
