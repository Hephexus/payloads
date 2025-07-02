/*
 * syscall_interceptor.s - Simulates interception and modification of a syscall result.
 *
 * Category: User‑Mode Payload
 *
 * This program calls getpid (syscall number 172), intercepts the returned PID
 * by adding 1, converts the modified PID to hexadecimal, and prints it.
 */
    .section .data
msg_intercepted:
    .asciz "Intercepted PID: "
    .section .bss
    .lcomm pid_hex, 18
    .section .text
    .global main
main:
    // Call getpid.
    mov x8, 172       // syscall: getpid.
    svc 0
    // Save original PID in x19.
    mov x19, x0
    // Intercept: modify PID (add 1).
    add x0, x0, #1
    // Convert modified PID to hex.
    bl num_to_hex
    // Print message.
    mov x0, 1
    adr x1, msg_intercepted
    mov x2, #18      // length of "Intercepted PID: ".
    mov x8, 64
    svc 0
    // Print intercepted PID.
    mov x0, 1
    adr x1, pid_hex
    mov x2, #17
    mov x8, 64
    svc 0
    // Exit.
    mov x0, 0
    mov x8, 93
    svc 0

num_to_hex:
    mov x6, x0
    mov x7, #16
    mov x8, #60
    mov x4, #0
num_to_hex_loop:
    lsr x9, x6, x8
    and x9, x9, #0xF
    cmp x9, #10
    blt less_than_ten
    add x9, x9, #55
    b store_digit
less_than_ten:
    add x9, x9, #48
store_digit:
    adr x10, pid_hex
    add x10, x10, x4
    strb w9, [x10]
    add x4, x4, #1
    subs x7, x7, #1
    sub x8, x8, #4
    b.ne num_to_hex_loop
    adr x10, pid_hex
    add x10, x10, x4
    mov w11, #10
    strb w11, [x10]
    ret
