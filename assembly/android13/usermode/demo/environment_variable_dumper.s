/*
 * environment_variable_dumper.s - Dumps the first environment variable.
 *
 * Category: User‑Mode Demo
 *
 * This program assumes main's third argument (envp) points to an array of environment strings and prints the first one.
 */
.section .text
.global main
main:
    // Assume: x0 = argc, x1 = argv, x2 = envp.
    ldr x1, [x2]   // Load the pointer to the first environment variable.
    // Calculate string length.
    mov x3, x1
    mov x4, #0
env_loop:
    ldrb w5, [x3, x4]
    cbz w5, env_done
    add x4, x4, #1
    b env_loop
env_done:
    mov x0, 1      // stdout.
    mov x2, x4     // string length.
    mov x8, 64     // syscall: write.
    svc 0
    mov x0, 0
    mov x8, 93     // exit.
    svc 0
