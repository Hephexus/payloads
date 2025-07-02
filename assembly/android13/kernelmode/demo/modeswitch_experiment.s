/*
 * modeswitch_experiment.s - Modeswitch Experiment Demo.
 *
 * Category: Kernel Mode Demo
 *
 * This module simulates experimenting with switching ARM exception levels.
 */
.extern printk
.section .text
.global init_module
.global cleanup_module
init_module:
    ldr x0, =msg_modeswitch
    bl printk
    mov x0, 0
    ret
cleanup_module:
    ldr x0, =msg_modeswitch_cleanup
    bl printk
    ret
.section .rodata
msg_modeswitch:
    .asciz "Kernel Module: Modeswitch Experiment Activated\n"
msg_modeswitch_cleanup:
    .asciz "Kernel Module: Modeswitch Experiment Deactivated\n"
