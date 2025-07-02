.section .text
.global find_kernel32

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