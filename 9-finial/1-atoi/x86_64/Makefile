AS = as -g
CC = gcc -g
LD = ld -g

main: atoi.o main.o
	$(CC) atoi.o main.o -o main

main.o: main.c
	$(CC) -c main.c -o main.o
	
atoi.o: atoi.S
	$(AS) atoi.S -o atoi.o

.PHONY: clean
clean:
	-rm -f main main.o atoi.o
