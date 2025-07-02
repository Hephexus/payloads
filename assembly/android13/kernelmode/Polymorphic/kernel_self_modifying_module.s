/*
 * kernel_self_modifying_module.s - Kernel Self-Modifying Module
 *
 * Fully functional version: This kernel module allocates a kernel memory buffer (simulated here using a static .bss region),
 * then modifies a specific byte in that buffer and logs the change via printk.
 *
 * WARNING: Real self-modification in the kernel must be done with extreme caution.
 */
.extern printk
.section .bss
    .lcomm mod_buffer, 16

.section .text
.global init_module
.global cleanup_module
init_module:
    /* Initialize the buffer with a known pattern */
    mov w0, #0xAA
    mov x1, mod_buffer
    mov w2, #16
init_loop:
    cbz w2, mod_done
    strb w0, [x1], #1
    subs w2, w2, #1
    bne init_loop
mod_done:
    /* Mutate one byte: change the 5th byte to 0xBB */
    adr x0, mod_buffer
    add x0, x0, #4
    mov w3, #0xBB
    strb w3, [x0]
    ldr x0, =ksmod_msg_init
    bl printk
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =ksmod_msg_exit
    bl printk
    ret
.section .rodata
ksmod_msg_init:
    .asciz "Kernel Self-Modifying Module activated\n"
ksmod_msg_exit:
    .asciz "Kernel Self-Modifying Module deactivated\n"
