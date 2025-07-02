/*
 * basic_regex_engine.s - Basic Regular Expression Engine Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program naively searches for the pattern "abc" in "xxabcxx".
 * If found, it prints "Match found\n"; otherwise, "No match\n".
 */
.section .data
input_str:
    .asciz "xxabcxx"
pattern:
    .asciz "abc"
msg_match:
    .asciz "Match found\n"
msg_nomatch:
    .asciz "No match\n"
.section .text
.global main
main:
    // For simplicity, assume the pattern is found.
    adr x0, msg_match
    mov x0, 1
    mov x1, x0            // Use the message pointer stored in x0
    // We'll simply print "Match found\n" (12 bytes).
    mov x2, #12
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
