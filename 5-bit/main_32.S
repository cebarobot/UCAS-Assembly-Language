# main.S
.section .data
    var0: .int 0x0812abcd
    var1: .int 0x80001234
.section .text
.globl _start
_start:
    # print_abs_hex(var0)
    pushl   var0
    call    print_abs_hex
    inc     %esp
    # print_abs_hex(var1)
    pushl   var1
    call    print_abs_hex

    # exit
    movl    $1, %eax
    movl    $0, %ebx
    int     $0x80

