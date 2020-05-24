.section .data
    bytevar:
    .rept   10
    .byte   0x0
    .endr
    .byte   13
    .byte   10
.section .text
    .globl  __start
__start:
    addiu   $sp, $sp, -16           # $sp = $sp - 16
    lui     $a0, %hi(bytevar)
    addiu   $a0, $a0, %lo(bytevar)
    jal     gen_str

    li      $v0, 4004       # $v0 = 4004
    li      $a0, 1          # $a0 = 1
    la      $a1, bytevar    # $a1 = bytevar
    li      $a2, 12         # $a2 = 12
    syscall
    li      $v0, 4001       # $v0 = 4001
    li      $a0, 0          # $a0 = 0
    syscall
