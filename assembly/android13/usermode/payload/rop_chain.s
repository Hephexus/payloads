// rop_chain.s - Android 13 ARM Sample ROP Chain Data
// This file contains sample gadget addresses for demonstration purposes.
.section .data
.global rop_chain
rop_chain:
    .word 0xdeadbeef
    .word 0xcafebabe
