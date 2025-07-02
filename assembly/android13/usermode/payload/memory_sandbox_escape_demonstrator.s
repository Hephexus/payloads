/*
 * memory_sandbox_escape_demonstrator.s - Memory Sandbox Escape Demonstrator Payload.
 *
 * This payload demonstrates a controlled out-of-bounds memory read within an allocated region.
 * It allocates 32 bytes using mmap, then reads a byte from an offset near the boundary,
 * and writes "Sandbox Escape Demonstrated\n" to stdout.
 */

.section .text
.global main
main:
    // Allocate 32 bytes using mmap.
    mov x0, 0            // addr = NULL
    mov x1, #32          // size = 32
    mov x2, #3           // prot = PROT_READ | PROT_WRITE
    mov x3, #0x22        // flags = MAP_PRIVATE | MAP_ANONYMOUS
    mov x4, #-1          // fd = -1
    mov x5, 0            // offset = 0
    mov x8, #222         // syscall: mmap
    svc 0               // x0 = pointer to allocated memory
    // For demonstration, read a byte from offset 31 (last byte).
    add x0, x0, #31     // Move pointer to near the end
    ldrb w6, [x0]       // Read byte (discard the value)

    // Now print a confirmation message.
    mov x0, #1
    adr x1, msg_escape
    mov x2, #30         // length of "Sandbox Escape Demonstrated\n"
    mov x8, #64         // syscall: write
    svc 0

    mov x0, #0
    mov x8, #93         // exit syscall
    svc 0

.section .rodata
msg_escape:
    .asciz "Sandbox Escape Demonstrated\n"
