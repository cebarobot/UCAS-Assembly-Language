# print_abs_hex.S
.section .text
.globl print_abs_hex
.type print_abs_hex, @function
print_abs_hex:
    subq    $16,        %rsp        # init 16 bytes stack
    movb    $0,         %r8b        # %r8 = 0
    test    %edi,       %edi
    jns     abs_endif               # %edi >= 0?
abs_if_else:                        # No: %edi < 0
    neg     %edi                    #   %edi = - %edi
    movb    $1,         %r8b        #   %r8b = 1
abs_endif:
    movb    $'\n',      11(%rsp)    # buf[11] = '\n'
    lea     10(%rsp),    %rcx       # char * p = &buf[10];
loop_start:
    movl    %edi,       %eax        # %eax = %edi
    andl    $0xf,       %eax        # %edi &= 0xf
    cmp     $10,        %eax
    jge     i2a_else                # %edi >= 10?
i2a_if:                             # No: %edi < 10
    addl    $'0',       %eax        #   %edi += '0'
    jmp     i2a_endif
i2a_else:                           # Yes: %edi >= 10
    addl    $('a'-10),  %eax        #   %edi += 'a' - 10
i2a_endif:
    movb    %al,        (%rcx)      # *p = %al
    shrl    $4,         %edi        # %edi >>= 4
    dec     %rcx                    # p--;
    test    %edi,       %edi        
    jnz     loop_start              # if (%edi != 0) loop;
loop_end:
    movb    $'x',       (%rcx)      # *p = 'x'
    movb    $'0',       -1(%rcx)    # *(p-1) = '0'
    # calculate length
    movq    $13,        %rdx
    addq    %rsp,       %rdx
    subq    %rcx,       %rdx        # %rax = 13 + buf - p
    test    %r8b,       %r8b
    jz      minus_endif             # %r8b == 0?
minus_if_else:
    movb    $'-',       -2(%rcx)    # *(p-2) = '-'
    inc     %rdx                    # %rdx += 1
    dec     %rcx                    # p --
minus_endif:
    # output
    movq    $1,         %rax        # syscall #: write
    movq    $1,         %rdi        # file: stdout
    lea     -1(%rcx),   %rsi        # string
    syscall
    
    # return 
    addq    $16,        %rsp        # clear stack
    ret                             # return

