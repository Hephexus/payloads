/*
 * asan_evade_payload.s - ASAN Evade Payload
 *
 * Performs operations in a tight loop with careful timing to avoid triggering AddressSanitizer detectors.
 * For demonstration, simply writes a message using write.
 */
 
.section .data
asan_msg:
    .asciz "ASAN Evade Payload executed\n"
 
.section .text
.global main
main:
    mov x0, #1
    adr x1, asan_msg
    mov x2, #30
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0
