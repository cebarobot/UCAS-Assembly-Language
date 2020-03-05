# ucas.S
.section .data
    output: .ascii "University of CAS\n"
    length = . - output                     # 计算字符串长度
.section .text
.global _start
_start:
# output
    movq    $1, %rax
    movq    $1, %rdi
    movq    $output, %rsi
    movq    $length, %rdx
    syscall
# exit
    movq    $60, %rax
    movq    $0, %rdi
    syscall
