/*
 * simple_json_parser.s - Simple JSON Parser Demo.
 *
 * Category: User‑Mode Demo
 *
 * This program checks if the JSON string "{\"key\":\"value\"}" contains a colon ':'.
 * If so, it prints "JSON Parsed\n"; otherwise, it prints "JSON Parse Error\n".
 */
.section .data
json_str:
    .asciz "{\"key\":\"value\"}"
msg_json:
    .asciz "JSON Parsed\n"
msg_error:
    .asciz "JSON Parse Error\n"
.section .text
.global main
main:
    adr x0, json_str
    mov x1, #0            // flag = 0
json_loop:
    ldrb w2, [x0], #1
    cbz w2, json_done
    cmp w2, #':'
    beq json_found
    b json_loop
json_found:
    mov x1, #1
json_done:
    cmp x1, #1
    beq print_json
    adr x3, msg_error
    b write_json
print_json:
    adr x3, msg_json
write_json:
    mov x0, 1
    mov x1, x3
    // Use fixed lengths: msg_json = 13 bytes, msg_error = 18 bytes.
    cmp x3, msg_json
    b.eq use_json_len
    mov x2, #18
    b finish_write
use_json_len:
    mov x2, #13
finish_write:
    mov x8, 64
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
