PPC?=powerpc-unknown-elf-
AS?=powerpc-unknown-elf-as
LD?=powerpc-unknown-elf-ld
OBJDUMP?=powerpc-unknown-elf-objdump
DIFF?=diff


.PHONY: all
all: ppc32_test2


.PHONY: ppc32_test
ppc32_test: ppc32_test.s ppc32_test.lds
	@echo "Assembling ppc32_test.s"
	@powerpc-unknown-elf-as -mbig ppc32_test.s -o ppc32_test.o
	@echo "Linking ppc32_test.o"
	@powerpc-unknown-elf-ld -T ppc32_test.lds ppc32_test.o -o ppc32_test
	@echo "Comparing generated code"
	@powerpc-unknown-elf-objdump -s -j .text ppc32_test > ppc32_test.objdump.s.j.text.txt
	-@diff ppc32_microcode.objdump.s.j.text.txt ppc32_test.objdump.s.j.text.txt
	@powerpc-unknown-elf-objdump -s -j .data ppc32_test > ppc32_test.objdump.s.j.data.txt
	-@diff ppc32_microcode.objdump.s.j.data.txt ppc32_test.objdump.s.j.data.txt

.PHONY: ppc32_test2
ppc32_test2:
	@echo "Compiling ppc32_test2_head.S ppc32_test2.c"
	powerpc-unknown-elf-gcc -O2 -mbig -nostdlib -Ttext=0xFFF00000 -Tbss=0x00004000 -o ppc32_test2 ppc32_test2_head.S ppc32_test2.c
	@echo "Inspecting..."
	powerpc-unknown-elf-objdump -d ppc32_test2
