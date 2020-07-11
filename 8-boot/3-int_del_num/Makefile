AS = as
CC = gcc
LD = ld
ASFLAGS = -32
CFLAGS = -Wall -march=i486 -m32 -O1 -fomit-frame-pointer -fno-builtin \
		 -ffreestanding -fPIC $(SMP_FL) -fno-stack-protector

.PHONY: all
all: clean memtest.bin test.img

test.img: memtest.bin
	cat memtest.bin > test.img

bootsect.tmp.s: bootsect.S defs.h
	$(CC) -E -traditional $< -o $@

memtest.bin: bootsect.tmp.o memtest.bin.lds
	$(LD) -T memtest.bin.lds bootsect.tmp.o -o memtest.bin

.PHONY: clean
clean:
	-rm -f *.o *.s *.iso memtest.bin memtest memtest_shared \
		memtest_shared.bin memtest.iso *.img 