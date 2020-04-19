# print_abs_hex.S
.section .text
.globl print_abs_hex
.type print_abs_hex, @function
print_abs_hex:
    pushl   %ebp
    movl    %esp,       %ebp
    subl    $16,        %esp        # init 16 bytes stack
    movl    %ebx,       15(%esp)    # restore %ebx
    movb    $0,         %bl         # %bl = 0
    movl    8(%ebp),    %edi        # %edi = x
    test    %edi,       %edi
    jns     abs_endif               # %edi >= 0?
abs_if_else:                        # No: %edi < 0
    neg     %edi                    #   %edi = - %edi
    movb    $1,         %bl         #   %bl = 1
abs_endif:
    movb    $'\n',      11(%esp)    # buf[11] = '\n'
    lea     10(%esp),   %ecx       # char * p = &buf[10];
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
    movb    %al,        (%ecx)      # *p = %al
    shrl    $4,         %edi        # %edi >>= 4
    dec     %ecx                    # p--;
    test    %edi,       %edi        
    jnz     loop_start              # if (%edi != 0) loop;
loop_end:
    movb    $'x',       (%ecx)      # *p = 'x'
    movb    $'0',       -1(%ecx)    # *(p-1) = '0'
    # calculate length
    movl    $13,        %edx
    addl    %esp,       %edx
    subl    %ecx,       %edx        # %eax = 13 + buf - p
    test    %bl,        %bl
    jz      minus_endif             # %e8b == 0?
minus_if_else:
    movb    $'-',       -2(%ecx)    # *(p-2) = '-'
    inc     %edx                    # %edx += 1
    dec     %ecx                    # p --
minus_endif:
    # output
    movl    $4,         %eax        # syscall #: write
    movl    $1,         %ebx        # file: stdout
    subl    $1,         %ecx        # string
    int     $0x80
    
    # return 
    movl    15(%esp),   %ebx        # resume %ebx
    addl    $16,        %esp        # clear stack
    leave
    ret                             # return

