#include "defs.h"
.code16
.section ".bootsect", "ax", @progbits
_boot:

# ld86 requires an entry symbol. This may as well be the usual one.
.globl _main
_main:
    movw    $BOOTSEG, %ax
    movw    %ax, %ds
    movw    $INITSEG, %ax
    movw    %ax, %es
    movw    $256, %cx
    subw    %si, %si
    subw    %di, %di
    cld
    rep
    movsw
    ljmp    $INITSEG, $go - _boot
go:
    movw    %cs, %ax
    movw    $(0x4000-12), %dx       # 0x4000 is arbitrary value >= length of
                                    # bootsect + length of setup + room for stack
                                    # 12 is disk parm size
    movw    %ax, %ds
    movw    %ax, %es
    movw    %ax, %ss                # put stack at INITSEG:0x4000 - 12.
    movw    %dx, %sp
    
# Print some inane message
    movb    $0x03, %ah              # read cursor pos
    xorb    %bh, %bh
    int     $0x10
    
    movw    $9, %cx
    movw    $0x0007, %bx            # page 0, attribute 7 (normal)
    movw    $msg1 - _boot, %bp
    movw    $0x1301, %ax            # write string, move cursor
    int     $0x10
1:  jmp     1b
msg1:
    .byte 13,10
    .ascii "Loading"
.org 510
boot_flag:
    .word 0xAA55
_eboot: