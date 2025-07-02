; Find function address (common)
section .text
global find_function

find_function:
    ; Preserve all registers
    pushad
    mov ebp, [esp + 0x24]
    mov eax, [ebp + 0x3c]
    mov edx, [ebp + eax + 0x78]
    add edx, ebp
    mov ecx, [edx + 0x18]
    mov ebx, [edx + 0x20]
    add ebx, ebp
find_function_loop:
    jecxz find_function_finished
    dec ecx
    mov esi, [ebx + ecx * 4]
    add esi, ebp
    xor edi, edi
    xor eax, eax
    cld
compute_hash:
    lodsb
    test al, al
    jz compute_hash_finished
    ror edi, 0xd
    add edi, eax
    jmp compute_hash
compute_hash_finished:
    cmp edi, [esp + 0x28]
    jnz find_function_loop
    mov ebx, [edx + 0x24]
    add ebx, ebp
    mov cx, [ebx + 2 * ecx]
    mov ebx, [edx + 0x1c]
    add ebx, ebp
    mov eax, [ebx + 4 * ecx]
    add eax, ebp
    mov [esp + 0x1c], eax
find_function_finished:
    popad
    ret