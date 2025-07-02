/*
 * heap_overflow_cve.s - Heap Overflow Exploit POC.
 *
 * This exploit allocates a small heap buffer and intentionally writes past its boundary,
 * demonstrating a heap overflow condition.
 *
 * WARNING: This may crash the process.
 */
 
.section .data
overflow_message:
    .asciz "Heap Overflow Triggered!\n"

.section .bss
    .lcomm heap_buffer, 64

.section .text
.global main
main:
    adr x0, heap_buffer
    mov w2, #80    // Attempt to write 80 bytes (16 bytes overflow)
    mov w3, #0x41  // Write the character 'A'
memset_loop:
    cbz w2, done_overflow
    strb w3, [x0], #1
    subs w2, w2, #1
    bne memset_loop
done_overflow:
    mov x0, #1
    adr x1, overflow_message
    mov x2, #25
    mov x8, #64
    svc 0
    mov x0, #0
    mov x8, #93
    svc 0
