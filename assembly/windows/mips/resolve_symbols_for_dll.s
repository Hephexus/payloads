.section .text
.global resolve_symbols_for_dll

resolve_symbols_for_dll:
    lw $a0, ($a1)
    addiu $a1, $a1, 4
    sw $a0, 0($a2)
    addiu $a2, $a2, 4
    bne $a1, $a3, resolve_symbols_for_dll
resolve_symbols_for_dll_finished:
    jr $ra