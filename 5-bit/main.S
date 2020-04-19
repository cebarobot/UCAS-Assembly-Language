# main.S
.section .data
    var0: .int 0x0812abcd
    var1: .int 0x80001234
.section .text
.globl _start
_start:
    # print_abs_hex(var0)
    movl    var0,    %edi
    call    print_abs_hex
    # print_abs_hex(var1)
    movl    var1,    %edi
    call    print_abs_hex

    # exit
    movq    $60, %rax
    movq    $0, %rdi
    syscall

