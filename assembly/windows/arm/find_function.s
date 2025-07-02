section .text
global find_function

find_function:
    ; Preserve all registers
    push {r0-r12, lr}
    mov r4, r0
    ldr r0, [r4, #0x3c]
    ldr r1, [r4, r0, lsl #2]
    add r1, r1, r4
    ldr r2, [r1, #0x18]
    ldr r3, [r1, #0x20]
    add r3, r3, r4
find_function_loop:
    subs r2, r2, #1
    bmi find_function_finished
    ldr r1, [r3, r2, lsl #2]
    add r1, r1, r4
    mov r5, #0
    mov r6, #0
compute_hash:
    ldrb r7, [r1], #1
    cmp r7, #0
    beq compute_hash_finished
    ror r5, r5, #13
    add r5, r5, r7
    b compute_hash
compute_hash_finished:
    ldr r7, [sp, #0x28]
    cmp r5, r7
    bne find_function_loop
    ldr r3, [r1, #0x24]
    add r3, r3, r4
    ldrh r2, [r3, r2, lsl #1]
    ldr r3, [r1, #0x1c]
    add r3, r3, r4
    ldr r0, [r3, r2, lsl #2]
    add r0, r0, r4
    str r0, [sp, #0x1c]
find_function_finished:
    pop {r0-r12, lr}
    bx lr