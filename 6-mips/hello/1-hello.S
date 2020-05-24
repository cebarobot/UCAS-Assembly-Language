.section .data
    output: .ascii "Hello, world!\n"
.section .text
    .globl __start
__start:
    li      $v0, 4004
    li      $a0, 1
    la      $a1, output
    li      $a2, 14
    syscall
    li      $v0, 4001
    li      $a0, 0
    syscall
