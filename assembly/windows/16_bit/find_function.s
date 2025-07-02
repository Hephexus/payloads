section .text
global find_function

find_function:
    ; Preserve all registers
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    mov bp, sp
    mov ax, [bp + 0x0e]
    mov dx, [bp + ax + 0x3c]
    mov cx, [bp + dx + 0x18]
    mov bx, [bp + dx + 0x20]
    add bx, bp
find_function_loop:
    jcxz find_function_finished
    dec cx
    mov si, ds:[bx + cx * 2]
    add si, bp
    xor di, di
    xor ax, ax
    cld
compute_hash:
    lodsb
    test al, al
    jz compute_hash_finished
    ror di, 0xd
    add di, ax
    jmp compute_hash
compute_hash_finished:
    cmp di, ds:[bp + 0x10]
    jnz find_function_loop
    mov bx, [bp + dx + 0x24]
    add bx, bp
    mov cx, ds:[bx + 2 * cx]
    mov bx, [bp + dx + 0x1c]
    add bx, bp
    mov ax, ds:[bx + 4 * cx]
    add ax, bp
    mov [bp + 0x0a], ax
find_function_finished:
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret