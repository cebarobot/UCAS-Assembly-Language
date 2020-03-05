# hello__64intel.S
    .intel_syntax noprefix          # 采用 Intel 语法，寄存器名前不加%
.section .data
    output: .ascii "Hello world\n"
.section .text
.global _start
_start:
# output
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, offset output
    mov     rdx, 12
    syscall
# exit
    mov     rax, 60
    mov     rdi, 0
    syscall
