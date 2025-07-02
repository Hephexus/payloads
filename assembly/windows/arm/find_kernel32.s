section .text
global find_kernel32

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