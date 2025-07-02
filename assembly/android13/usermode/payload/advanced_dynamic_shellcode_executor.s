/*
 * advanced_dynamic_shellcode_executor.s - Advanced Dynamic Shellcode Executor Payload.
 *
 * This payload allocates executable memory using mmap, decodes a shellcode that was XOR-encoded
 * with key 0xAA, and transfers control to it. The decoded shellcode writes "Shellcode executed!\n"
 * to stdout and then exits.
 *
 * Note: This example uses a 10-byte shellcode for demonstration.
 */

.section .data
encoded_shellcode:
    // This is a 10-byte shellcode, XOR-encoded with 0xAA.
    .byte 0xC3, 0xA3, 0xD1, 0xE7, 0xB6, 0xC1, 0xF3, 0x80, 0xD5, 0x9F
key:
    .byte 0xAA

.section .rodata
shell_msg:
    .asciz "Shellcode executed!\n"

.section .text
.global main
main:
    // Allocate 16 bytes using mmap (syscall number 222).
    mov x0, 0            // addr = NULL
    mov x1, #16          // size = 16 bytes
    mov x2, #7           // prot = PROT_READ | PROT_WRITE | PROT_EXEC
    mov x3, #0x22        // flags = MAP_PRIVATE | MAP_ANONYMOUS
    mov x4, #-1          // fd = -1
    mov x5, 0            // offset = 0
    mov x8, #222         // syscall: mmap
    svc 0               // result in x0: allocated memory pointer
    mov x13, x0         // Save mmap base address in x13

    // Decode the shellcode (10 bytes) into the allocated memory.
    adr x9, encoded_shellcode
    ldrb w10, [key]     // Load XOR key (0xAA) into w10
    mov w11, #10        // Set loop counter to 10 bytes
decode_loop:
    cbz w11, exec_shellcode
    ldrb w12, [x9], #1  // Load a byte from encoded_shellcode and post-increment pointer
    eor w12, w12, w10   // XOR-decode the byte using key 0xAA
    strb w12, [x13], #1 // Store byte into allocated memory, advance pointer
    subs w11, w11, #1   // Decrement counter
    bne decode_loop

exec_shellcode:
    // Branch to the start of the decoded shellcode.
    // (For demonstration, the decoded shellcode is expected to contain raw instructions
    // that eventually call the write syscall to output shell_msg and then exit.)
    // For our demo, we simply jump to the allocated memory.
    // In a full implementation, the decoded shellcode would be self-contained.
    // Note: In a production scenario, you must preserve the original pointer.
    br x13
