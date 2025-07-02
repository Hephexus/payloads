/*
 * binary_search_algorithm.s - Binary Search Algorithm Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program performs a binary search on a sorted array of 6 integers:
 * [1, 3, 5, 7, 9, 11]. The target value is 7. If found, it prints "Found at index: X\n"
 * where X is the index; if not, "Not found\n" is printed.
 */
.section .data
sorted_array:
    .word 1, 3, 5, 7, 9, 11
target_val:
    .word 7
msg_found:
    .asciz "Found at index: "
msg_not_found:
    .asciz "Not found\n"
.section .bss
    .lcomm index_str, 4      // Buffer for storing the index as a digit and newline.
.section .text
.global main
main:
    // Initialize low (x4) and high (x5)
    mov x4, #0         // low = 0
    mov x5, #5         // high = 5 (indices 0..5)
binary_loop:
    cmp x4, x5
    bgt binary_not_found
    add x6, x4, x5
    asr x6, x6, #1     // mid = (low + high) >> 1
    // Load array element: each element is 4 bytes.
    ldr w7, [sorted_array, x6, lsl #2]
    ldr w8, [target_val]
    cmp w7, w8
    beq binary_found
    cmp w7, w8
    bgt binary_set_high
    // Else: element < target; set low = mid + 1.
    add x4, x6, #1
    b binary_loop
binary_set_high:
    sub x5, x6, #1     // high = mid - 1.
    b binary_loop
binary_found:
    // Convert index (in x6) to ASCII (assumes single digit).
    add w6, w6, #48
    adr x9, index_str
    strb w6, [x9]
    add x9, x9, #1
    mov w10, #10       // Append newline (ASCII 10).
    strb w10, [x9]
    // Print "Found at index: " message.
    mov x0, 1
    adr x1, msg_found
    mov x2, #18        // Length of "Found at index: " (18 bytes).
    mov x8, 64       // write syscall.
    svc 0
    // Print index result.
    mov x0, 1
    adr x1, index_str
    mov x2, #2
    mov x8, 64
    svc 0
    b binary_exit
binary_not_found:
    // Print "Not found\n" message.
    mov x0, 1
    adr x1, msg_not_found
    mov x2, #10        // Assumed length.
    mov x8, 64
    svc 0
binary_exit:
    mov x0, 0
    mov x8, 93       // exit syscall.
    svc 0
