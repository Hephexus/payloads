section .text
global resolve_symbols_for_dll

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