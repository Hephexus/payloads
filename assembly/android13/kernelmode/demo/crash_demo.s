// crash_demo.s - Android 13 ARM Crash Demo Shellcode
// This shellcode intentionally dereferences a NULL pointer to force a crash.
.global _start
.section .text
_start:
    ldr x1, [xzr]          // Dereference xzr (NULL) to trigger a segmentation fault.
