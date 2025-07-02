section .text
global resolve_symbols_for_dll

resolve_symbols_for_dll:
    lodsw
    push ax
    push dx
    call find_function
    mov ds:[di], ax
    add sp, 4
    add di, 4
    cmp si, cx
    jne resolve_symbols_for_dll
resolve_symbols_for_dll_finished:
    ret