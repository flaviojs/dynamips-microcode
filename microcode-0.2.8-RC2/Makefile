PPC32?=powerpc-unknown-elf-
MIPS64?=mips64-unknown-elf-
DIFF?=diff


.PHONY: all
all: mips64_test


.PHONY: mips64_test
mips64_test: mips64_test.s mips64_test.lds
	@echo "-- Assembling mips64_test.s --"
	@mips64-unknown-elf-as mips64_test.s -o mips64_test.o
	@echo "-- Linking mips64_test.o --"
	@mips64-unknown-elf-ld -T mips64_test.lds mips64_test.o -o mips64_test
	@echo "-- Comparing generated code --"
	@mips64-unknown-elf-objdump -s -j .text mips64_test > mips64_test.objdump.s.j.text.txt
	-@diff --strip-trailing-cr mips64_microcode.objdump.s.j.text.txt mips64_test.objdump.s.j.text.txt
	@mips64-unknown-elf-objdump -s -j .rodata mips64_test > mips64_test.objdump.s.j.rodata.txt
	-@diff --strip-trailing-cr mips64_microcode.objdump.s.j.rodata.txt mips64_test.objdump.s.j.rodata.txt
	@mips64-unknown-elf-objdump -s -j .rodata.str1.8 mips64_test > mips64_test.objdump.s.j.rodata.str1.8.txt
	-@diff --strip-trailing-cr mips64_microcode.objdump.s.j.rodata.str1.8.txt mips64_test.objdump.s.j.rodata.str1.8.txt
	@mips64-unknown-elf-objdump -s -j .data mips64_test > mips64_test.objdump.s.j.data.txt
	-@diff --strip-trailing-cr mips64_microcode.objdump.s.j.data.txt mips64_test.objdump.s.j.data.txt
	@echo "-- Done --"


.PHONY: ppc32_test
ppc32_test: ppc32_test.s ppc32_test.lds
	@echo "-- Assembling ppc32_test.s --"
	@powerpc-unknown-elf-as -mbig ppc32_test.s -o ppc32_test.o
	@echo "-- Linking ppc32_test.o --"
	@powerpc-unknown-elf-ld -T ppc32_test.lds ppc32_test.o -o ppc32_test
	@echo "-- Comparing generated code --"
	@powerpc-unknown-elf-objdump -s -j .text ppc32_test > ppc32_test.objdump.s.j.text.txt
	-@diff ppc32_microcode.objdump.s.j.text.txt ppc32_test.objdump.s.j.text.txt
	@powerpc-unknown-elf-objdump -s -j .data ppc32_test > ppc32_test.objdump.s.j.data.txt
	-@diff ppc32_microcode.objdump.s.j.data.txt ppc32_test.objdump.s.j.data.txt
	@echo "-- Done --"


PPC32_CFLAGS=-O1 -mbig -nostdlib -Ttext=0xFFF00000 -Tbss=0x00004000
.PHONY: ppc32_test2
ppc32_test2:
	@echo "-- Removing ppc32_test2 --"
	-rm ppc32_test2
	@echo "-- Compiling ppc32_test2 (from ppc32_test2_head.S ppc32_test2.c) --"
	powerpc-unknown-elf-gcc $(PPC32_CFLAGS) -o ppc32_test2 ppc32_test2_head.S ppc32_test2.c
	@echo "-- Done --"
