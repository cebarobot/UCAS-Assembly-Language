# hello.S
.section .data
    output: .ascii "Hello world\n"
.section .text
.global _start
_start:
/* output */
    movl    $4, %eax            # %eax <= 4
    movl    $1, %ebx            # %ebx <= 1
    movl    $output, %ecx       # 
    movl    $12, %edx
    int     $0x80
/* exit */
    movl    $1, %eax
    movl    $0, %ebx
    int     $0x80

