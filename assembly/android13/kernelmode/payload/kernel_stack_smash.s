// kernel_stack_smash.s - Kernelmode Stack Smash Simulation
// Simulates smashing the kernel stack to hijack control.
// (In a real exploit this would modify stack contents; here we just print a message.)
.global _start
.section .text
_start:
    mov x0, #1                 // stdout
    ldr x1, =msg
    mov x2, #39                // length of message
    mov x8, #64                // sys_write (simulation)
    svc #0
    mov x0, #0
    mov x8, #93                // sys_exit
    svc #0
.section .data
msg: .asciz "Kernel stack smash simulated successfully!\n"
