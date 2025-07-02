// self_modifying_payload.s - Self-Modifying Shellcode Payload (Usermode)
// Modifies its own code then jumps to the modified region.
.global _start
.section .text
_start:
    adr x1, target_region         // Get address of target region
    mov w2, #0xD503201F           // ARM64 NOP instruction (encoded as immediate)
    str w2, [x1]                 // Overwrite target with NOP
    br target_region             // Jump to modified target region
target_region:
    // Now execute modified code: print a confirmation message.
    mov x0, #1
    ldr x1, =msg
    mov x2, #33
    mov x8, #64
    svc #0
    mov x0, #0
    mov x8, #93
    svc #0
.section .data
msg: .asciz "Self-modification complete!\n"
