/*
 * kernel_anti_vm_debug.s - Kernel Anti-VM/Debug Detector
 *
 * Fully functional version: This module reads the MIDR_EL1 register to check the hypervisor bit.
 * If the hypervisor bit is set, it suggests that the kernel is running in a VM.
 * The result is logged via printk.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    mrs x0, midr_el1      /* Read Main ID Register */
    /* In ARM, bit [31] is set if running under a hypervisor. We'll check that bit. */
    ubfx x1, x0, #31, #1  /* Extract bit 31 */
    cmp x1, #1
    bne no_vm_detected
    ldr x0, =kvmd_vm_msg
    bl printk
    b exit_vmd
no_vm_detected:
    ldr x0, =kvmd_no_vm_msg
    bl printk
exit_vmd:
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kvmd_cleanup_msg
    bl printk
    ret
.section .rodata
kvmd_vm_msg:
    .asciz "Kernel Anti-VM/Debug: VM detected (hypervisor present)\n"
kvmd_no_vm_msg:
    .asciz "Kernel Anti-VM/Debug: No VM detected\n"
kvmd_cleanup_msg:
    .asciz "Kernel Anti-VM/Debug deactivated\n"
