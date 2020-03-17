.section .data
    stringvar:
        .ascii "0123456789abcdef\n" # add a newline symbol
.section .text
.globl _start
_start:
    movq    $8, %rcx                # loop for 8 times, %rcx is also used as index
    movq    $stringvar, %rbx        # the addr for the string
LOOP1:                              # enter the loop
    movw    -2(%rbx, %rcx, 2), %ax  # move two byte to %ax
    xchg    %ah, %al                # exchange high and low 8 bits of %ax
    movw    %ax, -2(%rbx, %rcx, 2)  # move two byte back
    loop    LOOP1                   # loop
# output
# INFO: This part has been changed for Linux-64
    movq    $1, %rax
    movq    $1, %rdi
    movq    $stringvar, %rsi
    movq    $17, %rdx
    syscall
# exit
# INFO: This part has been changed for Linux-64
    movq    $60, %rax
    movq    $0, %rdi
    syscall
