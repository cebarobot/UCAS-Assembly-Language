#include "defs.h"
.code16
.section ".bootsect", "ax", @progbits
_boot:

# ld86 requires an entry symbol. This may as well be the usual one.
.globl _main
_main:
                                    # copy boot to new place
    movw    $BOOTSEG, %ax           
    movw    %ax, %ds                # %ds = $BOOTSEG, set data_segment to boot_segment
    movw    $INITSEG, %ax
    movw    %ax, %es                # %es = $INITSEG, set e_segment to init_segment
    movw    $256, %cx               # %cx = 0
    subw    %si, %si                # %si = 0
    subw    %di, %di                # %di = 0
    cld                             # DF = 0, set direction flag to increase
    rep                             # repeat while cx is not 0
    movsw                           # mov string as words (256 words = 512 bytes)

    ljmp    $INITSEG, $go - _boot   # long jump to init_segment:go
go:
    movw    %cs, %ax                # %ax = %cs, move code_segment to ax
    movw    $(0x4000-12), %dx       # 0x4000 is arbitrary value >= length of
                                    # bootsect + length of setup + room for stack
                                    # 12 is disk parm size
    jmp     next

inthandler:                         # toupper, start addr = ds:si
    pushw   %ax                     # store %ax
    pushw   %bx                     # store %bx
    pushw   %si                     # store %si
    movw    %si, %bx                # %bx = %si
1:
    movb    (%si), %al              # mov (%si) to %al
    test    %al, %al
    jz      1f                      # if %al == 0, jump tp 1 forward
    subb    $'0', %al               # %al = %al - '0'
    cmp     $10, %al
    jb      2f                      # if %al < 10, jump to 2 foward
    addb    $'0', %al               # %al = %al + '0'
    movb    %al, (%bx)              # move %al to (%bx)
    inc     %bx                     # %bx ++
2:
    inc     %si                     # %si ++
    jmp     1b                      # jump tp 1 backward
1:
    movb    $0, (%bx)               # move '\0' to (%bx)
    popw    %si                     # reload %si
    subw    %si, %bx                # %bx = %bx - %si
    movw    %bx, %cx                # %cx = %bx

    popw    %bx                     # reload %bx
    popw    %ax                     # reload %ax
    iret

next:
# change int 0x30 vector
    cli                             # clear interrupt
    xorw    %bx, %bx                # %bx = 0
    movw    %bx, %ds                # %ds = 0
    movw    $0x0c0, %bx             # %bx = 0x0c0 = 0x30 * 4
    movw    $inthandler - _boot, (%bx)  # mov inthandler to (%bx)
    movw    %ax, 2(%bx)             # mov code_segment to 2(%bx)
    sti

    movw    %ax, %ds                # %ds = %ax, set data_segment same as code_segment
    movw    %ax, %es                # %es = %ax, set e_segment same as code_segment
    movw    %ax, %ss                # %ss = %ax, set s_segment same as code_segment
    movw    %dx, %sp                # put stack at INITSEG:0x4000 - 12.
    
# Print some inane message
    movb    $0x03, %ah              # read cursor pos to dh:dl
    xorb    %bh, %bh                # %bh = 0, video_page_number = 0
    int     $0x10                   # call VGA_display

    movw    $msg1 - _boot, %si
    int     $0x30
    
    # movw    $9, %cx                 # %cx = 9, num_of_chars_in_buffer = 9
    movw    $0x0007, %bx            # page 0, attribute 7 (normal)
    movw    $msg1 - _boot, %bp      # %bp = msg1
    movw    $0x1301, %ax            # write string(es:bp, cx), move cursor
    int     $0x10                   # call VGA_display
1:  jmp     1b                      # jump to 1 backward, while (1);
msg1:
    .byte 13,10
    .ascii "123Loa2312ding123..."
.org 510
boot_flag:
    .word 0xAA55
_eboot: