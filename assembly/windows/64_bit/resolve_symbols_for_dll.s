section .text
global resolve_symbols_for_dll

resolve_symbols_for_dll:
    lodsq
    push rax
    push rdx
    call find_function
    mov [rdi], rax
    add rsp, 0x10
    add rdi, 0x08
    cmp rsi, rcx
    jne resolve_symbols_for_dll
resolve_symbols_for_dll_finished:
    ret