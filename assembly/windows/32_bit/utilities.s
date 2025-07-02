; Utility functions (common)
section .text
global resolve_symbols_for_dll

resolve_symbols_for_dll:
    lodsd
    push eax
    push edx
    call find_function
    mov [edi], eax
    add esp, 0x08
    add edi, 0x04
    cmp esi, ecx
    jne resolve_symbols_for_dll
resolve_symbols_for_dll_finished:
    ret