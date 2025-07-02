/*
 * bootstrapping_payload_loader.s - Bootstrapping Payload Loader
 *
 * This stager simulates loading a secondary payload from disk by reading a file
 * ("/data/local/tmp/boot_payload.bin") into an allocated memory region and then executing it.
 *
 * Syscalls used: open, read, mmap, close, exit.
 */
 
.section .data
boot_path:
    .asciz "/data/local/tmp/boot_payload.bin\0"
msg_boot_fail:
    .asciz "Boot payload load failed\n"
 
.section .text
.global main
main:
    /* Open boot payload file (O_RDONLY = 0) */
    adr x0, boot_path
    mov x1, #0
    mov x8, #56
    svc 0
    cmp x0, #0
    blt boot_fail
    mov x19, x0

    /* Allocate 256 bytes RWX */
    mov x0, 0
    mov x1, #256
    mov x2, #7
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0

    /* Read boot payload into allocated memory */
    mov x0, x19
    mov x1, x20
    mov x2, #256
    mov x8, #63
    svc 0

    /* Close file */
    mov x0, x19
    mov x8, #57
    svc 0

    /* Execute payload */
    mov x0, x20
    br x0

boot_fail:
    mov x0, #1
    adr x1, msg_boot_fail
    mov x2, #24
    mov x8, #64
    svc 0
    mov x0, #1
    mov x8, #93
    svc 0
