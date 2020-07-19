AS = as -g
CC = gcc -g
LD = ld -g

main: my_memcpy.o main.o
	$(CC) my_memcpy.o main.o -o main

main.o: main.c
	$(CC) -c main.c -o main.o

my_memcpy.o: my_memcpy.S
	$(AS) my_memcpy.S -o my_memcpy.o

.PHONY: clean
clean:
	-rm -f main main.o atoi.o
