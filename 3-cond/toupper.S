.section .data
    iostring:
        .asciz "ab1g2hA0H56po9wK78nB\n"
    length = . - iostring
.section .text
.globl _start
_start:
    mov     $iostring, %ebx     # char * %ebx = p
L1:
    movb    (%ebx), %al         # char %al = *p
    test    %al, %al            # check %al == 0
    jz      L2                  # break loop
    cmpb    $'a', %al           # check %al >= 'a'
    jb      L3                  # break if
    cmpb    $'z', %al           # check %al <= 'z'
    ja      L3                  # break if
    subb    $32, %al            # %al += 'A' - 'a'
    movb    %al, (%ebx)         # *p = %al
L3: 
    inc     %ebx                # %ebx ++
    jmp     L1
L2:
# output
# INFO: This part has been changed for Linux-64
    movq    $1, %rax
    movq    $1, %rdi
    movq    $iostring, %rsi
    movq    $length, %rdx
    syscall
# exit
# INFO: This part has been changed for Linux-64
    movq    $60, %rax
    movq    $0, %rdi
    syscall
