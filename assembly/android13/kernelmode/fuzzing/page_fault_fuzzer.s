/*
 * page_fault_fuzzer.s - Kernel Page Fault Fuzzer.
 *
 * This module intentionally accesses an address just beyond an allocated buffer to trigger a page fault.
 */
.extern printk
.section .bss
    .lcomm pf_buffer, 4096
.section .text
.global init_module
.global cleanup_module
init_module:
    adr x0, pf_buffer
    add x0, x0, #4100  // Access 4 bytes past the allocated buffer.
    ldrb w1, [x0]
    ldr x0, =pf_msg
    bl printk
    ret
cleanup_module:
    ldr x0, =pf_msg_deactivated
    bl printk
    ret
.section .rodata
pf_msg:
    .asciz "Kernel Page Fault Fuzzer executed\n"
pf_msg_deactivated:
    .asciz "Kernel Page Fault Fuzzer deactivated\n"
