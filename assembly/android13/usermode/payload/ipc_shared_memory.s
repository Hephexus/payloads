/*
 * ipc_shared_memory.s - Demonstrates IPC using shared memory via mmap.
 *
 * Category: User‑Mode Payload
 *
 * This program allocates a shared memory region using mmap, then forks a child
 * process. The child copies a message into the shared memory, and the parent busy-
 * waits until the shared memory is nonzero, then prints the message.
 */
    .section .text
    .global main
main:
    // Call mmap: addr=0, length=64, prot=PROT_READ|PROT_WRITE (3), flags=MAP_SHARED|MAP_ANONYMOUS (33), fd=-1, offset=0.
    mov x0, 0
    mov x1, #64
    mov x2, #3
    mov x3, #33
    mov x4, -1
    mov x5, 0
    mov x8, 222      // syscall: mmap.
    svc 0
    mov x20, x0     // x20 holds pointer to shared memory.
    // Initialize shared memory to zero.
    mov x21, #0
    strb w21, [x20]
    // Fork using clone (syscall 220; returns 0 in child).
    mov x0, #0
    mov x8, 220
    svc 0
    cmp x0, #0
    beq child_process
    // Parent process: busy-wait until shared memory is nonzero.
parent_loop:
    ldrb w1, [x20]
    cbz w1, parent_loop
    // Write shared memory content to stdout.
    mov x0, 1
    mov x1, x20
    mov x2, #20      // Assume message length 20.
    mov x8, 64
    svc 0
    // Exit.
    mov x0, 0
    mov x8, 93
    svc 0

child_process:
    // Child: copy message "Hello from child!\n" into shared memory.
    adr x1, child_msg
    mov x2, #20     // Message length.
    mov x3, x20     // Destination pointer.
copy_loop:
    ldrb w4, [x1], #1
    strb w4, [x3], #1
    subs x2, x2, #1
    bne copy_loop
    // Exit child.
    mov x0, 0
    mov x8, 93
    svc 0

    .section .data
child_msg:
    .asciz "Hello from child!\n"
