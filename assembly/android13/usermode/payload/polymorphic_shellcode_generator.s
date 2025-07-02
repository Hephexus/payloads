/*
 * polymorphic_shellcode_generator.s - Polymorphic Shellcode Generator Payload.
 *
 * Dynamically generates shellcode in memory that prints "Polymorphic Execution\n" to stdout
 * and then exits. For simplicity, this example directly prints the message using the write syscall.
 *
 * While real polymorphism would involve mutation of code at runtime, this demo serves as a basis.
 */

.section .data
poly_msg:
    .asciz "Polymorphic Execution\n"

.section .text
.global main
main:
    // Print the polymorphic execution message.
    mov x0, #1             // stdout
    adr x1, poly_msg       // address of message
    mov x2, #23            // message length (23 bytes)
    mov x8, #64            // syscall: write
    svc 0                  // perform write syscall

    mov x0, #0             // exit status 0
    mov x8, #93            // syscall: exit
    svc 0
