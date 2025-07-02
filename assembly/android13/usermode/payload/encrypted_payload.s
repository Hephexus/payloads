// encrypted_payload.s - Usermode Encrypted Payload Loader
// Decodes XOR-encrypted code with key 0x55 and then jumps to it.
.global _start
.section .text
_start:
    ldr x0, =data_start         // Start of encrypted payload
    ldr x1, =data_end           // End address
    mov w2, #0x55               // XOR key
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
    br x0                     // Jump to decoded payload
.section .data
// 'encrypted.bin' should contain the XOR-encrypted payload.
data_start:
    .incbin "encrypted.bin"
data_end:
