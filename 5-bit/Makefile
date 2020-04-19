main: main.o print_abs_hex.o
	ld main.o print_abs_hex.o -o main

main.o: main.S
	as -g main.S -o main.o

print_abs_hex.o: print_abs_hex.S
	as -g print_abs_hex.S -o print_abs_hex.o

main_32: main_32.o print_abs_hex_32.o
	ld -m elf_i386 main_32.o print_abs_hex_32.o -o main_32

main_32.o: main_32.S
	as --32 -g main_32.S -o main_32.o

print_abs_hex_32.o: print_abs_hex_32.S
	as --32 -g print_abs_hex_32.S -o print_abs_hex_32.o

clean:
	rm main main.o print_abs_hex.o main_32 main_32.o print_abs_hex_32.o