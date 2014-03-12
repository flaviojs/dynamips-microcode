AS?=powerpc-unknown-elf-as
LD?=powerpc-unknown-elf-ld
OBJDUMP?=powerpc-unknown-elf-objdump
DIFF?=diff


.PHONY: all
all: ppc32_test


.PHONY: ppc32_test
ppc32_test: ppc32_test.s ppc32_test.lds
	@echo "Assembling ppc32_test.s"
	@$(AS) -mbig ppc32_test.s -o ppc32_test.o
	@echo "Linking ppc32_test.o"
	@$(LD) -T ppc32_test.lds ppc32_test.o -o ppc32_test
	@echo "Comparing generated code"
	@$(OBJDUMP) -s -j .text ppc32_test > ppc32_test.objdump.s.j.text.txt
	-@$(DIFF) ppc32_microcode.objdump.s.j.text.txt ppc32_test.objdump.s.j.text.txt
	@$(OBJDUMP) -s -j .data ppc32_test > ppc32_test.objdump.s.j.data.txt
	-@$(DIFF) ppc32_microcode.objdump.s.j.data.txt ppc32_test.objdump.s.j.data.txt
