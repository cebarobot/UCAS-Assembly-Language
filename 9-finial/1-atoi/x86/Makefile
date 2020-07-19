AS = as -g --32
CC = gcc -g -m32
LD = ld -g -m elf_i386

main: atoi.o main.o
	$(CC) atoi.o main.o -o main

main.o: main.c
	$(CC) -c main.c -o main.o

atoi.o: atoi.S
	$(AS) atoi.S -o atoi.o

.PHONY: clean
clean:
	-rm -f main main.o atoi.o
