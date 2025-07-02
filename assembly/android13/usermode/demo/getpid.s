// getpid.s - Android 13 ARM Getpid Shellcode
// This code retrieves the current process ID and exits with it as the exit code.
.global _start
.section .text
_start:
    mov x8, #172          // sys_getpid (AArch64 Linux: 172)
    svc #0                // call getpid; PID returned in x0
    // Exit, using PID as the exit code for demonstration
    mov x8, #93           // sys_exit (93 on AArch64)
    svc #0
