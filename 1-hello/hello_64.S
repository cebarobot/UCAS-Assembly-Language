# hello.S
.section .data
    output: .ascii "Hello world\n"
.section .text
.global _start
_start:
# output
    movq $1, %rax
    movq $2, %rdi
    movq $output, %rsi
    movq $12, %rdx
    syscall
# exit
    movq $60, %rax
    movq $0, %rdi
    syscall
