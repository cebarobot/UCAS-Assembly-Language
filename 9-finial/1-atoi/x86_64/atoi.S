.globl	atoi
.type atoi, @function
atoi:   # 
    xorl    %eax, %eax          # %eax = 0;
    xorl    %esi, %esi          # %esi = 0;

# ignore space
    movzbl  (%rdi), %ecx        # %ecx = *(%rdi);
    jmp     loop_space          # enter loop
loop_space_body:
    inc     %rdi                # %rdi ++;
    movzbl  (%rdi), %ecx        # %ecx = *(%rdi);
loop_space:
    cmpb    $' ', %cl           # if (%cl == ' ') 
    je      loop_space_body     #     goto loop_space_body;
    leal    -0x9(%rcx), %edx    # else if (0x0 <= %cl <= 0x4) 
    cmpb    $5, %dl             #     // %cl == '\t' || '\n' || '\v' || '\f' || '\r'
    jb      loop_space_body     #     goto loop_space_body;

# check sign
if_sign_pos:
    cmpb    $'+', %cl           # if (%cl == '+')
    jne     if_sign_neg

    inc     %rdi                # %rdi ++;
    movzbl  (%rdi), %ecx        # %ecx = *(%rdi);
    jmp     if_sign_end
if_sign_neg:
    cmpb    $'-', %cl           # else if (%cl == '-')
    jne     if_sign_end

    inc     %rdi                # %rdi ++;
    movzbl  (%rdi), %ecx        # %ecx = *(%rdi);
    movl    $1, %esi            # %esi = 1
if_sign_end:

# convert
    sub     $'0', %ecx          # %ecx -= '0'
    jmp     loop_convert        # enter loop
loop_convert_body:
    imull   $10, %eax           # %eax *= 10
    jo      overflow            # if (overflow) goto overflow

    test    %esi, %esi          # if (%esi) do convert_neg;
    jnz     convert_if_neg     # else do convert_pos;
convert_if_pos:
    add     %ecx, %eax          # %eax += %ecx
    jo      overflow            # if (overflow) goto overflow
    jmp     convert_if_end
convert_if_neg:
    sub     %ecx, %eax          # %eax -= %ecx
    jo      overflow            # if (overflow) goto overflow
convert_if_end:
    inc     %rdi                # %rdi ++;
    movzbl  (%rdi), %ecx        # %ecx = *(%rdi);
    sub     $'0', %ecx          # %ecx -= '0'
loop_convert:
    cmpb    $10, %cl            # if (%cl < 10)
    jb      loop_convert_body   # continue;

loop_convert_end:
    ret

overflow:
    movl    $0x7FFFFFFF, %eax   # %eax = 0x7FFFFFFF
    test    %esi, %esi          # if (%esi)
    jz      overflow_if_end
overflow_if_neg:
    not     %eax                # %eax = ~ %eax
overflow_if_end:
    jmp loop_convert_end        # break;