	# NOTES:
	# Code that doesn't use stack (dunno how to make gcc produce it)
	# powerpc, 32-bit, big endian
	.machine "ppc32"
	.globl _start


	# Entry point of executable
	# 6.4.1 System Reset Exception (0x00100)
	.org 0x00100, 0
_start:
cpu_exception_00100:
	li      %r3,0xC00
	lis     %r4,cpu_exception_00C00@h
	addi    %r4,%r4,cpu_exception_00C00@l
	li      %r5,sizeof_cpu_exception_00C00
	bl      my_memcpy
	# // copy "System Call Exception" code to other exception vector
	# memcpy(0xC00, &cpu_exception_00C00, sizeof_cpu_exception_00C00)
	li      %r3,0x500
	lis     %r4,cpu_exception_00500@h
	addi    %r4,%r4,cpu_exception_00500@l
	li      %r5,sizeof_cpu_exception_00500
	bl      my_memcpy
	# // copy "External Interrupt" code to other exception vector
	# memcpy(0x500, &cpu_exception_00500, sizeof_cpu_exception_00500)
	li      %r3,0x900
	lis     %r4,cpu_exception_00900@h
	addi    %r4,%r4,cpu_exception_00900@l
	li      %r5,sizeof_cpu_exception_00900
	bl      my_memcpy
	# // copy "Decrementer Exception" code to other exception vector
	# memcpy(0x900, &cpu_exception_00900, sizeof_cpu_exception_00900)
	bl      start_microcode
	# // start microcode (ROMMON emulation)
	# start_microcode()
	nop


	# 6.4.5 External Interrupt (0x00500)
	.org 0x00500, 0
cpu_exception_00500:
	rfi
	# // return from interrupt
	.set sizeof_cpu_exception_00500, . - cpu_exception_00500


	# 6.4.9 Decrementer Exception (0x00900)
	.org 0x00900, 0
cpu_exception_00900:
	rfi
	# // return from interrupt
	.set sizeof_cpu_exception_00900, . - cpu_exception_00900


	# 6.4.10 System Call Exception (0x00C00)
	.org 0x00C00, 0
cpu_exception_00C00:
	mtsprg  1,%r10
	# // SPRG[1] = r10
	lis     %r10,0x00004000@h
	addi    %r10,%r10,0x00004000@l
	# // r10 = 0x00004000
	stw     %r8,0(%r10)
	# // save r8
	stw     %r9,4(%r10)
	# // save r9
	mfsprg  %r8,1
	stw     %r8,8(%r10)
	# // save r10 (backed up in SPRG[1])
	mflr    %r9
	stw     %r9,12(%r10)
	# // save LR (link register)
	mfxer   %r8
	stw     %r8,16(%r10)
	# // save XER register
	mfcr    %r9
	stw     %r9,20(%r10)
	# // save CR (count register)
	lis     %r8,syscall_handler@h
	addi    %r8,%r8,syscall_handler@l
	mtlr    %r8
	blrl
	# // call the system call exception handler
	# syscall_handler()
	lis     %r10,0x00004000@h
	addi    %r10,%r10,0x00004000@l
	# // r10 = 0x00004000
	lwz     %r8,20(%r10)
	mtcr    %r8
	# // restore CR (count register)
	lwz     %r9,16(%r10)
	mtxer   %r9
	# // restore XER register
	lwz     %r8,12(%r10)
	mtlr    %r8
	# // restore LR (link register)
	lwz     %r8,0(%r10)
	# // restore r8
	lwz     %r9,4(%r10)
	# // restore r9
	lwz     %r10,8(%r10)
	# // restore r10
	rfi
	# // return from interrupt
	.set sizeof_cpu_exception_00C00, . - cpu_exception_00C00


	# start of the 3rd page (used for implementation-specific purposes)
	.org 0x03000, 0
