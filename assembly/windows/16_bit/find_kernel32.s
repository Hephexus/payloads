section .text
global find_kernel32

find_kernel32:
    ; Preserve registers
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    xor ax, ax
    mov ax, ds:[0x30]
    test ax, ax
    js find_kernel32_9x
find_kernel32_nt:
    mov ax, ds:[ax + 0x0c]
    mov si, ds:[ax + 0x1c]
    lodsw
    mov ax, ds:[si + 0x08]
    jmp find_kernel32_finished
find_kernel32_9x:
    mov ax, ds:[ax + 0x34]
    lea ax, ds:[ax + 0x7c]
    mov ax, ds:[ax + 0x3c]
find_kernel32_finished:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret