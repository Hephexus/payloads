/*
 * kernel_selinux_disable.s - Kernel SELinux Disable
 *
 * This module simulates disabling SELinux from within the kernel by writing to a dummy variable.
 */
.extern printk
.section .bss
    .lcomm kselinux_flag, 8
.section .text
.global init_module
.global cleanup_module
init_module:
    mov x0, #0         /* Set SELinux mode to 0 */
    adr x1, kselinux_flag
    str x0, [x1]
    ldr x0, =kselinux_msg
    bl printk
    mov x0, #0
    ret
cleanup_module:
    mov x0, #1         /* Restore SELinux mode */
    adr x1, kselinux_flag
    str x0, [x1]
    ldr x0, =kselinux_msg_exit
    bl printk
    ret
.section .rodata
kselinux_msg:
    .asciz "Kernel SELinux disable executed\n"
kselinux_msg_exit:
    .asciz "Kernel SELinux disable module deactivated\n"
