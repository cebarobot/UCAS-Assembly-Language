AS = as -g
CC = gcc -g
LD = ld -g

main: atoi.o main.o
	gcc atoi.o main.o -o main

.PHONY: clean
clean:
	-rm -f main main.o atoi.o
