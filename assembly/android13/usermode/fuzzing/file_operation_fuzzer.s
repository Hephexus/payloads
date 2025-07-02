/*
 * file_operation_fuzzer.s - User-Mode File Operation Fuzzer.
 *
 * This fuzzer opens /dev/null with different flags and then performs a read,
 * logging the iteration.
 */
 
.section .data
dev_null:
    .asciz "/dev/null\0"
msg_file:
    .asciz "File Operation Fuzzer iteration complete\n"

.section .text
.global main
main:
    adr x0, dev_null
    mov x1, #0        // O_RDONLY
    mov x8, #56       // open syscall
    svc 0
    mov x19, x0      // Save file descriptor in x19
    mov x0, x19
    adr x1, dev_null  // Use dev_null as dummy buffer pointer
    mov x2, #10
    mov x8, #63      // read syscall
    svc 0
    mov x0, #1
    adr x1, msg_file
    mov x2, #39
    mov x8, #64
    svc 0
    mov x0, x19
    mov x8, #57     // close syscall
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0
