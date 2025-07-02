/*
 * anti_vm_detector.s - Anti-VM Detector
 *
 * This module opens "/proc/cpuinfo", reads its contents, and searches for the string "QEMU".
 * Detection of "QEMU" is taken as evidence of a virtualized environment.
 */
 
.section .bss
    .lcomm cpuinfo_buf, 512

.section .data
proc_cpuinfo:
    .asciz "/proc/cpuinfo\0"
msg_vm:
    .asciz "Virtualization Detected (QEMU present)\n"
msg_no_vm:
    .asciz "No Virtualization Detected (QEMU absent)\n"

.section .text
.global main
main:
    /* Open /proc/cpuinfo */
    adr x0, proc_cpuinfo
    mov x1, #0
    mov x8, #56
    svc 0
    mov x19, x0

    /* Read up to 512 bytes into cpuinfo_buf */
    mov x0, x19
    adr x1, cpuinfo_buf
    mov x2, #512
    mov x8, #63
    svc 0

    /* Close file descriptor */
    mov x0, x19
    mov x8, #57
    svc 0

    /* Simple search for "QEMU" (Q = 0x51) in cpuinfo_buf */
    adr x3, cpuinfo_buf
search_vm:
    ldrb w4, [x3], #1
    cmp w4, #0
    beq no_vm_found
    cmp w4, #0x51   /* 'Q' */
    bne search_vm
    /* If found, assume VM detected */
    mov x0, #1
    adr x1, msg_vm
    mov x2, #39
    mov x8, #64
    svc 0
    b exit_vm
no_vm_found:
    mov x0, #1
    adr x1, msg_no_vm
    mov x2, #40
    mov x8, #64
    svc 0
exit_vm:
    mov x0, #0
    mov x8, #93
    svc 0
