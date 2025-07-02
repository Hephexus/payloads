/*
 * random_input_fuzzer.s - User-Mode Random Input Fuzzer.
 *
 * This fuzzer uses a simple linear congruential generator to produce pseudo-random numbers,
 * and then uses them as dummy parameters to a write syscall.
 */
 
.section .data
msg_rand:
    .asciz "Random Input Fuzzer iteration complete\n"

.section .text
.global main
main:
    mov w0, #1234      // Initialize seed
rand_loop:
    mov w1, w0
    mov w2, #1103515245
    mul w0, w0, w2
    add w0, w0, #12345
    and w3, w0, #0xFFFF  // Use lower 16 bits as parameter
    mov x0, #1
    mov x8, #64         // Dummy write syscall
    svc 0
    mov x0, #1
    adr x1, msg_rand
    mov x2, #43
    mov x8, #64
    svc 0
    subs w0, w0, #1
    bgt rand_loop
    mov x0, #0
    mov x8, #93
    svc 0
