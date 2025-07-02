// kernel_rop_chain.s - Kernel ROP Chain Data (Kernelmode)
// Contains gadget addresses for use in kernel ROP chains.
.section .data
.global kernel_rop_chain
kernel_rop_chain:
    .quad 0xdeadbeefdeadbeef
    .quad 0xcafebabecafebabe
