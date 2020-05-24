.section .data
    var0: .int 0x9812abcd
    var1: .int 0x0fff
.section .text
    .globl  __start
__start:
    addiu   $sp, $sp, -16           # $sp = $sp - 16
    la      $t1, var0
    lw      $a0, 0($t1)
    jal     printd

    la      $t1, var1
    lw      $a0, 0($t1)
    jal     printd

    li      $v0, 4001       # $v0 = 4001
    li      $a0, 0          # $a0 = 0
    syscall
