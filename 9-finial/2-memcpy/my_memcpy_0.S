.globl my_memcpy
.type my_memcpy, @function
my_memcpy:
    movq    %rdx, %rcx
    movq    %rdi, %rax
    cld
    rep movsb
    ret
