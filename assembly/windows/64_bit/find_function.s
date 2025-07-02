section .text
global find_function

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