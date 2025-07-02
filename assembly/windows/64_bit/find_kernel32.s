section .text
global find_kernel32

find_kernel32:
    ; Preserve registers
    push rsi
    xor rax, rax
    mov rax, gs:[rax + 0x60]
    test rax, rax
    js find_kernel32_9x
find_kernel32_nt:
    mov rax, [rax + 0x18]
    mov rsi, [rax + 0x30]
    lodsq
    mov rax, [rax + 0x10]
    jmp find_kernel32_finished
find_kernel32_9x:
    mov rax, [rax + 0x34]
    lea rax, [rax + 0x7c]
    mov rax, [rax + 0x3c]
find_kernel32_finished:
    pop rsi
    ret