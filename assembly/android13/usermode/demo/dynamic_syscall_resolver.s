/*
 * dynamic_syscall_resolver.s - Dynamically resolves a syscall number from a table.
 *
 * Category: User‑Mode Demo
 *
 * This program uses a table to retrieve the syscall number for getpid,
 * calls it, converts the returned PID to hexadecimal, and prints it.
 */
.section .data
syscall_table:
    .quad 64      // write
    .quad 93      // exit
    .quad 172     // getpid
msg_resolved:
    .asciz "Resolved PID: "
.section .bss
    .lcomm resolved_hex, 18
.section .text
.global main
main:
    adr x1, syscall_table
    ldr x2, [x1, #16]    // Retrieve third entry: getpid.
    mov x8, x2
    svc 0               // Call getpid (result in x0).
    bl num_to_hex_resolved
    mov x0, 1
    adr x1, msg_resolved
    mov x2, #14       // "Resolved PID: " length.
    mov x8, 64
    svc 0
    mov x0, 1
    adr x1, resolved_hex
    mov x2, #17
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0

num_to_hex_resolved:
    mov x6, x0
    mov x7, #16
    mov x8, #60
    mov x4, #0
num_to_hex_loop_res:
    lsr x9, x6, x8
    and x9, x9, #0xF
    cmp x9, #10
    blt less_than_ten_res
    add x9, x9, #55
    b store_digit_res
less_than_ten_res:
    add x9, x9, #48
store_digit_res:
    adr x10, resolved_hex
    add x10, x10, x4
    strb w9, [x10]
    add x4, x4, #1
    subs x7, x7, #1
    sub x8, x8, #4
    b.ne num_to_hex_loop_res
    adr x10, resolved_hex
    add x10, x10, x4
    mov w11, #10
    strb w11, [x10]
    ret
