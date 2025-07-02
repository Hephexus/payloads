// dynamic_exec.s - Dynamic Execution Payload (Usermode)
// Computes an address via PC-relative addressing and jumps to it.
.global _start
.section .text
_start:
    adr x0, payload_location      // Compute address of payload_location using PC-relative addressing
    br x0                        // Jump to payload location
payload_location:
    // Payload: print a message
    mov x0, #1
    ldr x1, =msg
    mov x2, #32
    mov x8, #64
    svc #0
    mov x0, #0
    mov x8, #93
    svc #0
.section .data
msg: .asciz "Dynamic execution completed!\n"
