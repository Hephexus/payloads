.section .text
.global find_function

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