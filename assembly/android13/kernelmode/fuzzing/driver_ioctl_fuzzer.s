/*
 * driver_ioctl_fuzzer.s - Driver IOCTL Fuzzer.
 *
 * This module opens a dummy driver (/dev/null) and repeatedly issues ioctl calls with iteration-dependent values.
 */
.extern printk
.section .data
dev_path:
    .asciz "/dev/null\0"
msg_ioctl:
    .asciz "Kernel IOCTL Fuzzer iteration executed\n"
.section .text
.global init_module
.global cleanup_module
init_module:
    adr x0, dev_path
    mov x1, #2         // O_RDWR
    mov x8, #56        // open syscall
    svc 0
    mov x19, x0        // store file descriptor in x19
    mov w0, #0
ioctl_loop:
    mov x0, x19
    // Use the current iteration value as a dummy ioctl command.
    mov x1, x0
    mov x8, #16        // ioctl syscall
    svc 0
    mov x0, #1
    adr x1, msg_ioctl
    mov x2, #40
    mov x8, #64
    svc 0
    add w0, w0, #1
    cmp w0, #3
    blt ioctl_loop
    mov x0, x19
    mov x8, #57        // close syscall
    svc 0
    mov x0, #0
    ret
cleanup_module:
    ldr x0, =kioctl_msg_deactivated
    bl printk
    ret
.section .rodata
kioctl_msg_deactivated:
    .asciz "Kernel IOCTL Fuzzer deactivated\n"
