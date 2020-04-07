.section .data
testdata:
    .byte 'A', '0', 'z', 'P', '8', 'r', 'Z', '2', 'f', 'H'
    length = . - testdata
newline:
    .ascii "\n"
.section .text
.globl _start
_start:
    movq    $testdata,  %rdi
    movl    $length,    %esi
    call    insert_sort
# output
    movq    $testdata,  %rdi
    movq    $length,    %rsi
    call    as_puts
# exit
    call    as_exit

# void insert_sort(char * s, int n)
# %rdi: s, %esi: n
.globl insert_sort
.type insert_sort, @function
insert_sort:
    movq    $1,     %rbx            # %rbx: i = 1
    jmp     L_out_loop_cond         # 跳转至外层循环条件判断部分：i < n
L_out_loop_body:                    # 外层循环体
    movb    (%rdi, %rbx),    %r12b   # %r12b: tmp = a[i]
    movq    %rbx,   %rbp            # %rbp: j = i
    dec     %rbp                    # %rbp: j--
    jmp     L_in_loop_cond_1        # 跳转至内层循环判断1

L_in_loop_body:                     # 内层循环体
    movb    (%rdi, %rbp),   %al     # %al = a[j]
    movb    %al,    1(%rdi, %rbp)   # a[j+1] = %al
    dec     %rbp                    # j--

L_in_loop_cond_1:                   # 内层循环判断1
    cmpq    $0,     %rbp            # j >= 0?
    jnge    L_in_loop_end           # 不满足则跳转至内层循环结尾

L_in_loop_cond_2:                   # 内层循环判断2
    cmpb    %r12b,  (%rdi, %rbp)    # a[j] > tmp?
    jg      L_in_loop_body          # 跳转至内层循环体

L_in_loop_end:                      # 内层循环结尾
    movb    %r12b,  1(%rdi, %rbp)   # a[j+1] = tmp

    inc     %rbx                    # i++
L_out_loop_cond:                    # 外层循环判断
    cmpq    %rsi,   %rbx            # i(ebx) < n(esi)?
    jl      L_out_loop_body         # 跳转至外层循环体
    ret

# int as_puts(char * s, int n)
# 输出长为 n 的字符串 s，并附带一个换行
.globl as_puts
.type as_puts, @function
as_puts:
    movq    $1,         %rax    # syscall #: write
    movq    %rsi,       %rdx    # length
    movq    %rdi,       %rsi    # string
    movq    $1,         %rdi    # file: stdout
    syscall
    movq    $1,         %rax    # syscall #: write
    movq    $1,         %rdi    # file: stdout
    movq    $newline,   %rsi    # string: "\n"
    movq    $1,         %rdx    # length: 1
    syscall
    ret

# void as_exit(void)
.globl as_exit
.type as_exit, @function
as_exit:
    movq    $60,    %rax
    movq    $0,     %rdi
    syscall
