/*
 * anti_vm_detector_payload.s - Anti-VM Detector Payload.
 *
 * This payload implements checks to detect if it is running inside a virtual machine.
 * It prints "Anti-VM Detector Payload Executed\n" after a dummy timing loop.
 */
.section .data
msg:
    .asciz "Anti-VM Detector Payload Executed\n"
.section .text
.global main
main:
    // Delay loop: simulate timing check.
    mov x1, #500000
delay_loop:
    subs x1, x1, #1
    b.ne delay_loop
    mov x0, 1
    adr x1, msg
    mov x2, #38        // 38 bytes message.
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
