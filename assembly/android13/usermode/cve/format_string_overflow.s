/*
 * format_string_overflow.s - Format String Overflow Exploit POC.
 *
 * This exploit simulates a vulnerability by passing a crafted format string to a
 * vulnerable printf-like routine (simulated here with write).
 *
 * WARNING: In a real exploit, target a genuinely vulnerable function.
 */
 
.section .data
vuln_format:
    .asciz "%x %x %x %x %x %x\n"   // Crafted vulnerable format string.
exploit_data:
    .quad 0x4141414141414141
    .quad 0x4242424242424242
    .quad 0x4343434343434343
    .quad 0x4444444444444444

.section .text
.global main
main:
    /* Write the malicious format string to stdout (for demo) */
    mov x0, #1
    adr x1, vuln_format
    mov x2, #32
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0
