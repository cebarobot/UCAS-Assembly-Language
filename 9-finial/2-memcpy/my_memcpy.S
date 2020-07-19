.globl my_memcpy
.type my_memcpy, @function
my_memcpy:
    pushq   %r12                # retore %r12 ~ %r15
    pushq   %r13
    pushq   %r14
    pushq   %r15

    movq    %rdi, %rax

# move in blocks of 1 byte
move_1_byte:
    test    $0x1, %rdx
    jz      move_2_bytes        # if (%rdx % 2 == 0) goto move_2_bytes;
    movb    (%rsi), %r8b
    movb    %r8b, (%rdi)        # *(%rdi) = *(%rsi)
    addq    $1, %rsi            # %rsi += 1
    addq    $1, %rdi            # %rdi += 1
    addq    $-1, %rdx           # %rdx -= 1

move_2_bytes:
    test    $0x3, %rdx
    jz      move_4_bytes        # if (%rdx % 4 == 0) goto move_4_bytes;
    movw    (%rsi), %r8w
    movw    %r8w, (%rdi)        # *(%rdi) = *(%rsi)
    addq    $2, %rsi            # %rsi += 2
    addq    $2, %rdi            # %rdi += 2
    addq    $-2, %rdx           # %rdx -= 2

move_4_bytes:
    test    $0x7, %rdx
    jz      move_8_bytes        # if (%rdx % 8 == 0) goto move_8_bytes;
    movl    (%rsi), %r8d
    movl    %r8d, (%rdi)        # *(%rdi) = *(%rsi)
    addq    $4, %rsi            # %rsi += 4
    addq    $4, %rdi            # %rdi += 4
    addq    $-4, %rdx           # %rdx -= 4

move_8_bytes:
    test    $0xF, %rdx
    jz      move_2_8_bytes      # if (%rdx % 16 == 0) goto move_2_8_bytes;
    movq    (%rsi), %r8
    movq    %r8, (%rdi)         # *(%rdi) = *(%rsi)
    addq    $8, %rsi            # %rsi += 8
    addq    $8, %rdi            # %rdi += 8
    addq    $-8, %rdx           # %rdx -= 8

move_2_8_bytes:
    test    $0x1F, %rdx
    jz      move_4_8_bytes      # if (%rdx % 32 == 0) goto move_4_8_bytes;
    movq    (%rsi), %r8
    movq    8(%rsi), %r9
    movq    %r8, (%rdi) 
    movq    %r9, 8(%rdi)        # *(%rdi) = *(%rsi)
    addq    $16, %rsi           # %rsi += 16
    addq    $16, %rdi           # %rdi += 16
    addq    $-16, %rdx          # %rdx -= 16

move_4_8_bytes:
    test    $0x3F, %rdx
    jz      move_8_8_bytes      # if (%rdx % 64 == 0) goto move_8_8_bytes;
    movq    (%rsi), %r8
    movq    8(%rsi), %r9
    movq    16(%rsi), %r10
    movq    24(%rsi), %r11
    movq    %r8, (%rdi) 
    movq    %r9, 8(%rdi)
    movq    %r10, 16(%rdi)
    movq    %r11, 24(%rdi)      # *(%rdi) = *(%rsi)
    addq    $32, %rsi           # %rsi += 32
    addq    $32, %rdi           # %rdi += 32
    addq    $-32, %rdx          # %rdx -= 32

move_8_8_bytes:
    test    %rdx, %rdx
    jz      my_memcpy_end       # if (%rdx == 0) exit;

    movq    (%rsi), %r8
    movq    8(%rsi), %r9
    movq    16(%rsi), %r10
    movq    24(%rsi), %r11
    movq    32(%rsi), %r12
    movq    40(%rsi), %r13
    movq    48(%rsi), %r14
    movq    56(%rsi), %r15
    movq    %r8, (%rdi) 
    movq    %r9, 8(%rdi)
    movq    %r10, 16(%rdi)
    movq    %r11, 24(%rdi) 
    movq    %r12, 32(%rdi)
    movq    %r13, 40(%rdi)
    movq    %r14, 48(%rdi)
    movq    %r15, 56(%rdi)      # *(%rdi) = *(%rsi)
    addq    $64, %rsi           # %rsi += 64
    addq    $64, %rdi           # %rdi += 64
    addq    $-64, %rdx          # %rdx -= 64
    jmp     move_8_8_bytes

my_memcpy_end:

    popq    %r15                # resume %r12 ~ %r15
    popq    %r14
    popq    %r13
    popq    %r12
    ret
