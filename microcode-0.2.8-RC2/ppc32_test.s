		# References I'm using:
		#
		# Name: PowerPC Microprocessor Family: The Programming Environments for 32-Bit Microprocessors
		# Publication Number: G522-0290-01
		# Revision Date: 2000-02-21
		# Filename: 6xx_pem.pdf
		# Link: https://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/852569B20050FF778525699600719DF2
		#
		# Name: Developing PowerPC Embedded Application Binary Interface (EABI) Compliant Programs
		# Revision Date: 1998-09-21
		# Filename: eabi_app.pdf
		# Link: https://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/852569B20050FF77852569970071B0D6
		#

		# global config
		.machine "ppc32"

		# aliases to be compatible with objdump output
		.set r0, 0	# volatile, link register
		.set r1, 1	# dedicated, stack pointer
		.set r2, 2	# dedicated, read-only small data area anchor
		.set r3, 3	# volatile, parameter passing, return value
		.set r4, 4	# volatile, parameter passing, return value
		.set r5, 5	# volatile, parameter passing
		.set r6, 6	# volatile, parameter passing
		.set r7, 7	# volatile, parameter passing
		.set r8, 8	# volatile, parameter passing
		.set r9, 9	# volatile, parameter passing
		.set r10, 10	# volatile, parameter passing
		.set r11, 11	# volatile
		.set r12, 12	# volatile
		.set r13, 13	# dedicated, read-write small data area anchor
		.set r14, 14	# non-volatile
		.set r15, 15	# non-volatile
		.set r16, 16	# non-volatile
		.set r17, 17	# non-volatile
		.set r18, 18	# non-volatile
		.set r19, 19	# non-volatile
		.set r20, 20	# non-volatile
		.set r21, 21	# non-volatile
		.set r22, 22	# non-volatile
		.set r23, 23	# non-volatile
		.set r24, 24	# non-volatile
		.set r25, 25	# non-volatile
		.set r26, 26	# non-volatile
		.set r27, 27	# non-volatile
		.set r28, 28	# non-volatile
		.set r29, 29	# non-volatile
		.set r30, 30	# non-volatile
		.set r31, 31	# non-volatile

		# remote control (0xf600????, dev_remote.c)
		.set REMOTE_CTRL_ADDRESS, 0xf6000000
		.set REMOTE_CTRL_0000, REMOTE_CTRL_ADDRESS+0x0000	# ROM Identification tag
		.set REMOTE_CTRL_0004, REMOTE_CTRL_ADDRESS+0x0004	# CPU ID
		.set REMOTE_CTRL_0008, REMOTE_CTRL_ADDRESS+0x0008	# Display CPU registers
		.set REMOTE_CTRL_000c, REMOTE_CTRL_ADDRESS+0x000c	# Display CPU memory info
		.set REMOTE_CTRL_0010, REMOTE_CTRL_ADDRESS+0x0010	# Reserved/Unused
		.set REMOTE_CTRL_0014, REMOTE_CTRL_ADDRESS+0x0014	# RAM size
		.set REMOTE_CTRL_0018, REMOTE_CTRL_ADDRESS+0x0018	# ROM size
		.set REMOTE_CTRL_001c, REMOTE_CTRL_ADDRESS+0x001c	# NVRAM size
		.set REMOTE_CTRL_0020, REMOTE_CTRL_ADDRESS+0x0020 	# IOMEM size
		.set REMOTE_CTRL_0024, REMOTE_CTRL_ADDRESS+0x0024	# Config Register
		.set REMOTE_CTRL_0028, REMOTE_CTRL_ADDRESS+0x0028	# ELF entry point
		.set REMOTE_CTRL_002c, REMOTE_CTRL_ADDRESS+0x002c	# ELF machine id
		.set REMOTE_CTRL_0030, REMOTE_CTRL_ADDRESS+0x0030	# Restart IOS Image
		.set REMOTE_CTRL_0034, REMOTE_CTRL_ADDRESS+0x0034	# Stop the virtual machine
		.set REMOTE_CTRL_0038, REMOTE_CTRL_ADDRESS+0x0038	# Debugging/Log message: /!\ physical address
		.set REMOTE_CTRL_003c, REMOTE_CTRL_ADDRESS+0x003c	# Console Buffering
		.set REMOTE_CTRL_0040, REMOTE_CTRL_ADDRESS+0x0040	# Console output
		.set REMOTE_CTRL_0044, REMOTE_CTRL_ADDRESS+0x0044	# NVRAM address
		.set REMOTE_CTRL_0048, REMOTE_CTRL_ADDRESS+0x0048	# IO memory size for Smart-Init (C3600, others ?)
		.set REMOTE_CTRL_004c, REMOTE_CTRL_ADDRESS+0x004c	# Cookie position selector
		.set REMOTE_CTRL_0050, REMOTE_CTRL_ADDRESS+0x0050	# Cookie data
		.set REMOTE_CTRL_0054, REMOTE_CTRL_ADDRESS+0x0054	# ROMMON variable
		.set REMOTE_CTRL_0058, REMOTE_CTRL_ADDRESS+0x0058	# ROMMON variable command

		# constants
		.set ROM_ID, 0x1e94b3df

		##############################
		# executable code
		# address = 0xfff00000
		# size = 0x4000
		.section .text
		.align 2
		.global _start

		.org 0x0000, 0
		# start of first page (0x1000 bytes)
		# 7.2.1.1 Predefined Physical Memory Locations
		# (...) the first 256 bytes of memory located at physical 
		# address 0xFFF0_0000 are assigned for arbitrary use by the 
		# operating system
		#
		# The rest of that first page (...) is either used for 
		# exception vectors, or reserved for future exception vectors.

		.org 0x0100, 0
		# Entry point of executable
		# 6.4.1 System Reset Exception (0x00100)
_start:
fff00100:	li      r3,0xC00
fff00104:	lis     r4,_fff00c00@h
fff00108:	addi    r4,r4,_fff00c00@l
fff0010c:	li      r5,sizeof_fff00c00
fff00110:	bl      _memcpy	# _memcpy(0xC00, _fff00c00, sizeof_fff00c00)
fff00114:	li      r3,0x500
fff00118:	lis     r4,_fff00500@h
fff0011c:	addi    r4,r4,_fff00500@l
fff00120:	li      r5,sizeof_fff00500
fff00124:	bl      _memcpy	# _memcpy(0x500, _fff00500, sizeof_fff00500)
fff00128:	li      r3,0x900
fff0012c:	lis     r4,_fff00900@h
fff00130:	addi    r4,r4,_fff00900@l
fff00134:	li      r5,sizeof_fff00900
fff00138:	bl      _memcpy	# _memcpy(0x900, _fff00900, sizeof_fff00900)
fff0013c:	bl      _main
fff00140:	nop


		.org 0x200, 0
		# 6.4.2 Machine Check Exception (0x00200)


		.org 0x300, 0
		# 6.4.3 DSI Exception (0x00300)


		.org 0x400, 0
		# 6.4.4 ISI Exception (0x00400)


		.org 0x500, 0
		# 6.4.5 External Interrupt (0x00500)
start_500:
_fff00500:	rfi
end_500:
		.set sizeof_fff00500, end_500-start_500


		.org 0x600, 0
		# 6.4.6 Alignment Exception (0x00600)


		.org 0x700, 0
		# 6.4.7 Program Exception (0x00700)


		.org 0x800, 0
		# 6.4.8 Floating-Point Unavailable Exception (0x00800)


		.org 0x900, 0
		# 6.4.9 Decrementer Exception (0x00900)
start_900:
_fff00900:	rfi
end_900:
		.set sizeof_fff00900, end_900-start_900


		.org 0xC00, 0
		# 6.4.10 System Call Exception (0x00C00)
start_c00:
_fff00c00:	mtsprg  1,r10
fff00c04:	lis     r10,_00004000@h
fff00c08:	addi    r10,r10,_00004000@l
fff00c0c:	stw     r8,0(r10)	# save r8
fff00c10:	stw     r9,4(r10)	# save r9
fff00c14:	mfsprg  r8,1	# r8 = SPRG1
fff00c18:	stw     r8,8(r10)	# save SPRG1
fff00c1c:	mflr    r9
fff00c20:	stw     r9,12(r10)	# save link register
fff00c24:	mfxer   r8
fff00c28:	stw     r8,16(r10)	# save XER register
fff00c2c:	mfcr    r9
fff00c30:	stw     r9,20(r10)	# save count register
fff00c34:	lis     r8,_syscall@h
fff00c38:	addi    r8,r8,_syscall@l
fff00c3c:	mtlr    r8		# set link register
fff00c40:	blrl			# call link register
fff00c44:	lis     r10,_00004000@h
fff00c48:	addi    r10,r10,_00004000@l
fff00c4c:	lwz     r8,20(r10)	# restore count register
fff00c50:	mtcr    r8
fff00c54:	lwz     r9,16(r10)	# restore XER register
fff00c58:	mtxer   r9
fff00c5c:	lwz     r8,12(r10)	# restore link register
fff00c60:	mtlr    r8
fff00c64:	lwz     r8,0(r10)	# restore r8
fff00c68:	lwz     r9,4(r10)	# restore r9
fff00c6c:	lwz     r10,8(r10)	# r10 = saved SPRG1
fff00c70:	rfi	# return from interrupt
end_c00:
		.set sizeof_fff00c00, end_c00-start_c00


		.org 0xD00, 0
		# 6.4.11 Trace Exception (0x00D00)


		.org 0xE00, 0
		# 6.4.12 Floating-Point Assist Exception (0x00E00)


		.org 0x1000, 0
		# end of first page
		# start of second page (0x1000 bytes)
		# 7.2.1.1 Predefined Physical Memory Locations
		# (...) the second and third pages located at physical address
		# 0xFFF0_1000 (...) are also used for implementation-specific 
		# purposes

		.org 0x2000, 0
		# end of second page
		# start of third page (0x1000 bytes)

		.org 0x3000, 0
		# end of third page
		.func memcpy
		.type _memcpy, "function"
		# similar to memcpy
		# input: r3 = destination, r4 = source, r5 = num
		# output:
_memcpy:
fff03000:	lbz     r30,0(r4)	# load byte from r4
fff03004:	stb     r30,0(r3)	# store byte to r3
fff03008:	addi    r3,r3,1		# r3++
fff0300c:	addi    r4,r4,1		# r4++
fff03010:	addi    r5,r5,-1	# r5--
fff03014:	cmpwi   r5,0
fff03018:	bne+    _memcpy		# if (r5 != 0) continue
fff0301c:	blr			# return
		.endfunc


		.func launch_image
		.type _launch_image, "function"
		# launches the image (ELF entry point)
		# dunno if it matters but r3,r4,r5 are set to 2,0,0
		# input: r3 = image address
		# output:
_launch_image:
fff03020:	mtctr   r3	# Count Register (CTR) = r3
fff03024:	li      r3,2
_fff03028:	li      r4,0
fff0302c:	li      r5,0
fff03030:	mtcr    r4	# Condition Register = 0
fff03034:	mtxer   r4	# XER Register (XER) = 0
fff03038:	bctrl	# goto Count Register (CTR)
		.endfunc


		.func restart_image
		.type _restart_image, "function"
		# TODO not implemented
		# restarts the image (ELF entry point)
		# input: r3 = image address
		# output:
_restart_image:
fff0303c:	blr
		.endfunc


		.func strcpy
		.type _strcpy, "function"
		# similar to strcpy, doesn't copy NUL terminator
		# input: r3 = destination, r4 = source
		# output:
_strcpy:
fff03040:	lbz     r0,0(r4)
fff03044:	extsb.  r0,r0
fff03048:	beqlr	# if (source[0] == 0) return
fff0304c:	mr      r9,r3
_fff03050:	stb     r0,0(r9)
fff03054:	addi    r9,r9,1
fff03058:	lbzu    r0,1(r4)
fff0305c:	extsb.  r0,r0
fff03060:	bne+    _fff03050	# if ((++source)[0] != 0) goto _fff03050
fff03064:	blr	# return
		.endfunc


		# unused function
fff03068:	mr.     r0,r5
fff0306c:	mtctr   r0
fff03070:	blelr   
fff03074:	lbz     r0,0(r4)
fff03078:	li      r11,0
fff0307c:	stb     r0,0(r3)
fff03080:	lbz     r0,0(r4)
fff03084:	cmpwi   cr7,r0,0
fff03088:	bne+    cr7,_fff030a4
fff0308c:	blr
		#
_fff03090:	lbzx    r0,r11,r4
fff03094:	stbx    r0,r11,r3
fff03098:	lbzx    r9,r11,r4
fff0309c:	cmpwi   cr7,r9,0
fff030a0:	beqlr   cr7
		#
_fff030a4:	addi    r11,r11,1
fff030a8:	bdnz+   _fff03090
fff030ac:	blr
fff030b0:	lbz     r0,0(r3)
fff030b4:	mr      r9,r3
fff030b8:	li      r3,0
fff030bc:	cmpwi   cr7,r0,0
fff030c0:	beqlr   cr7
		#
_fff030c4:	addi    r3,r3,1
fff030c8:	lbzx    r0,r3,r9
fff030cc:	cmpwi   cr7,r0,0
fff030d0:	bne+    cr7,_fff030c4
fff030d4:	blr


		.func fprintf
		.type _fprintf, "function"
		# similar to fprintf
		# input: r3 = stream (0-console,!0-log), r4 = text, {r5,r6,r7,r8,r9,r10,stack+?} = arguments
		# output:
		# stack(64)
		# stack+4 =
		# stack+8 = 2 (byte)
		# stack+12 = stack+72 (word)	# argv_ptr = argv [8..inf[
		# stack+16 = stack+16 (word)	# argv[0]
		# stack+20 =			# argv[1]
		# stack+24 = r5 (word)		# argv[2]
		# stack+28 = r6 (word)		# argv[3]
		# stack+32 = r7 (word)		# argv[4]
		# stack+36 = r8 (word)		# argv[5]
		# stack+40 = r9 (word)		# argv[6]
		# stack+44 = r10 (word)		# argv[7]
		# stack+48 = r28 (word)
		# stack+52 = r29 (word)
		# stack+56 = r30 (word)
		# stack+60 = r31 (word)
		# stack+64
		# stack+68 = r0 (link register)
		# stack+72 = argv[8]
		# ...
_fprintf:
fff030d8:	mflr    r0		# get link register
fff030dc:	stwu    r1,-64(r1)	# reserve stack(64)
fff030e0:	stw     r29,52(r1)	# save r29
fff030e4:	mr      r29,r3		# r29 = r3
fff030e8:	stw     r30,56(r1)	# save r30
fff030ec:	mr      r30,r4		# r30 = r4
fff030f0:	stw     r28,48(r1)	# save r28
fff030f4:	stw     r31,60(r1)	# save r31
fff030f8:	stw     r0,68(r1)	# save r0 (link register)
fff030fc:	lbz     r0,0(r4)
fff03100:	stw     r9,40(r1)	# save r9
fff03104:	addi    r9,r1,72
fff03108:	extsb.  r4,r0
fff0310c:	li      r0,2
fff03110:	stb     r0,8(r1)	# save 2 (byte)	
fff03114:	addi    r0,r1,16
fff03118:	stw     r5,24(r1)	# save r5
fff0311c:	stw     r6,28(r1)	# save r6
fff03120:	stw     r7,32(r1)	# save r7
fff03124:	stw     r8,36(r1)	# save r8
fff03128:	stw     r10,44(r1)	# save r19
fff0312c:	stw     r9,12(r1)	# save stack+72
fff03130:	stw     r0,16(r1)	# save stack+16
fff03134:	beq-    _fff031c0	# if (character == 0) goto _fff031c0
fff03138:	lis     r9,aNull@h
fff0313c:	addi    r28,r9,aNull@l	# r28 = "(null)"
fff03140:	b       _fff0315c
		# process normal character
_fff03144:	clrlwi  r4,r4,24	# r4 = (r4)&0xff
		# print character
_fff03148:	mr      r3,r29
fff0314c:	bl      _fputc	# _fputc(stream, r4)
		# get next character
_fff03150:	lbzu    r0,1(r30)	# r0 = get next byte
fff03154:	extsb.  r4,r0
fff03158:	beq-    _fff031c0	# if (character == 0) goto _fff031c0
		# process character
_fff0315c:	cmpwi   cr7,r4,'%'
fff03160:	bne+    cr7,_fff03144	# if (byte != '%') goto _fff03144
		# process '%' character
fff03164:	lbzu    r0,1(r30)	# r0 = get next byte
fff03168:	extsb   r0,r0
fff0316c:	cmpwi   cr7,r0,'s'
fff03170:	beq-    cr7,_fff032ec	# if (byte == 's') goto _fff032ec
fff03174:	bgt-    cr7,_fff031e4	# if (byte > 's') goto _fff031e4
fff03178:	cmpwi   cr7,r0,'%'
fff0317c:	beq-    cr7,_fff03324	# if (byte == '%') goto _fff03324
fff03180:	cmpwi   cr7,r0,'c'
fff03184:	bne+    cr7,_fff03150	# if (byte != 'c') goto _fff03150
		# process "%c"
fff03188:	lbz     r11,8(r1)	# r11 = next_argument
fff0318c:	cmplwi  cr7,r11,8
fff03190:	bge-    cr7,_fff03344	# if (r11 >= 8) goto _fff03344
fff03194:	rlwinm  r0,r11,2,0,29	# r0 = r11*4
fff03198:	lwz     r9,16(r1)	# r9 = argv
fff0319c:	addi    r11,r11,1
fff031a0:	stb     r11,8(r1)	# ++next_argument
fff031a4:	add     r9,r0,r9
		# process "%c" argument
_fff031a8:	lbz     r4,3(r9)	# r4 = *(byte*)(argv+r0+3)
fff031ac:	mr      r3,r29
fff031b0:	bl      _fputc	# _fputc(stream, r4)
fff031b4:	lbzu    r0,1(r30)
fff031b8:	extsb.  r4,r0
fff031bc:	bne+    _fff0315c
		# end
_fff031c0:	lwz     r0,68(r1)	# restore r0 (link register)
fff031c4:	li      r3,0		# r3 = 0
fff031c8:	lwz     r28,48(r1)	# restore r28
fff031cc:	lwz     r29,52(r1)	# restore r29
fff031d0:	mtlr    r0		# restore link register
fff031d4:	lwz     r30,56(r1)	# restore r30
fff031d8:	lwz     r31,60(r1)	# restore r31
fff031dc:	addi    r1,r1,64	# restore stack(64)
fff031e0:	blr	# return
		# continue processing '%' character
_fff031e4:	cmpwi   cr7,r0,'x'
fff031e8:	bne+    cr7,_fff03150	# if (byte != 'x') goto _fff03150
		# process "%x"
fff031ec:	lbz     r11,8(r1)	# r11 = next_argument
fff031f0:	cmplwi  cr7,r11,8
fff031f4:	bge-    cr7,_fff03334	# if (r11 >= 8) goto _fff03334
fff031f8:	rlwinm  r0,r11,2,0,29	# r0 = r11*4
fff031fc:	lwz     r9,16(r1)	# r9 = argv
fff03200:	addi    r11,r11,1
fff03204:	stb     r11,8(r1)	# ++next_argument
fff03208:	add     r9,r0,r9
		# process "%x" argument
_fff0320c:	lwz     r31,0(r9)	# r31 = argv[r11]
fff03210:	rlwinm  r9,r31,4,28,31	# r9 = (r31/0x10000000)&0xf
fff03214:	cmplwi  cr7,r9,9
fff03218:	addi    r4,r9,'0'
fff0321c:	ble-    cr7,_fff03224	# if (r9 <= 9) goto _fff03224
fff03220:	addi    r4,r9,'a'-10
		# print hex character
_fff03224:	mr      r3,r29
fff03228:	bl      _fputc	# _fputc(stream, r4)
fff0322c:	rlwinm  r9,r31,8,28,31	# r9 = (r31/0x1000000)&0xf
fff03230:	cmplwi  cr7,r9,9
fff03234:	addi    r4,r9,'0'
fff03238:	ble-    cr7,_fff03240	# if (r9 <= 9) goto _fff03240
fff0323c:	addi    r4,r9,'a'-10
		# print hex character
_fff03240:	mr      r3,r29
fff03244:	bl      _fputc	# _fputc(stream, r4)
fff03248:	rlwinm  r9,r31,12,28,31	# r9 = (r31/0x100000)&0xf
fff0324c:	cmplwi  cr7,r9,9
fff03250:	addi    r4,r9,'0'
fff03254:	ble-    cr7,_fff0325c	# if (r9 <= 9) goto _fff0325c
fff03258:	addi    r4,r9,'a'-10
		# print hex character
_fff0325c:	mr      r3,r29
fff03260:	bl      _fputc	# _fputc(stream, r4)
fff03264:	rlwinm  r9,r31,16,28,31	# r9 = (r31/0x10000)&0xf
fff03268:	cmplwi  cr7,r9,9
fff0326c:	addi    r4,r9,'0'
fff03270:	ble-    cr7,_fff03278	# if (r9 <= 9) goto _fff03278
fff03274:	addi    r4,r9,'a'-10
		# print hex character
_fff03278:	mr      r3,r29
fff0327c:	bl      _fputc	# _fputc(stream, r4)
fff03280:	rlwinm  r9,r31,20,28,31	# r9 = (r31/0x1000)&0xf
fff03284:	cmplwi  cr7,r9,9
fff03288:	addi    r4,r9,'0'
fff0328c:	ble-    cr7,_fff03294	# if (r9 <= 9) goto _fff03294
fff03290:	addi    r4,r9,'a'-10
		# print hex character
_fff03294:	mr      r3,r29
fff03298:	bl      _fputc	# _fputc(stream, r4)
fff0329c:	rlwinm  r9,r31,24,28,31	# r9 = (r31/0x100)&0xf
fff032a0:	cmplwi  cr7,r9,9
fff032a4:	addi    r4,r9,'0'
fff032a8:	ble-    cr7,_fff032b0	# if (r9 <= 9) goto _fff032b0
fff032ac:	addi    r4,r9,'a'-10
		# print hex character
_fff032b0:	mr      r3,r29
fff032b4:	bl      _fputc	# _fputc(stream, r4)
fff032b8:	rlwinm  r9,r31,28,28,31	# r9 = (r31/0x10)&0xf
fff032bc:	cmplwi  cr7,r9,9
fff032c0:	addi    r4,r9,'0'
fff032c4:	ble-    cr7,_fff032cc	# if (r9 <= 9) goto _fff032cc
fff032c8:	addi    r4,r9,'a'-10
		# print hex character
_fff032cc:	mr      r3,r29
fff032d0:	bl      _fputc	# _fputc(stream, r4)
fff032d4:	clrlwi  r9,r31,28	# r9 = (r31)&0xf
fff032d8:	cmplwi  cr7,r9,9
fff032dc:	addi    r4,r9,'a'-10
fff032e0:	bgt-    cr7,_fff03148	# if(r9 > 9) go print character in normal loop
fff032e4:	addi    r4,r9,'0'
fff032e8:	b       _fff03148	# go print character in normal loop
		# process "%s"
_fff032ec:	lbz     r11,8(r1)	# r11 = next_argument
fff032f0:	cmplwi  cr7,r11,8
fff032f4:	bge-    cr7,_fff03354	# if (r11 >= 8) goto _fff03354
fff032f8:	rlwinm  r0,r11,2,0,29	# r0 = r11*4
fff032fc:	lwz     r9,16(r1)	# r9 = argv
fff03300:	addi    r11,r11,1
fff03304:	stb     r11,8(r1)	# ++next_argument
fff03308:	add     r4,r0,r9
fff0330c:	lwz     r4,0(r4)	# r4 = argv[r11]
fff03310:	cmpwi   cr7,r4,0
fff03314:	beq-    cr7,_fff0336c	# if (r4 == 0) goto _fff0336c
		# process "%s" argument
_fff03318:	mr      r3,r29
fff0331c:	bl      _fputs	# _fputs(stream, r4)
fff03320:	b       _fff03150	# go get next character in normal loop
		# process "%%"
_fff03324:	mr      r3,r29
fff03328:	li      r4,'%'
fff0332c:	bl      _fputc	# _fputc(stream, '%')
fff03330:	b       _fff03150	# go get next character in normal loop
		# get "%x" argument from stack
_fff03334:	lwz     r9,12(r1)	# r9 = argv_ptr
fff03338:	addi    r0,r9,4
fff0333c:	stw     r0,12(r1)	# argv_ptr += 4
fff03340:	b       _fff0320c
		# get "%c" argument from stack
_fff03344:	lwz     r9,12(r1)	# r9 = argv_ptr
fff03348:	addi    r0,r9,4
fff0334c:	stw     r0,12(r1)	# argv_ptr += 4
fff03350:	b       _fff031a8
		# get "%s" argument from stack
_fff03354:	lwz     r4,12(r1)	# r4 = argv_ptr
fff03358:	addi    r0,r4,4
fff0335c:	stw     r0,12(r1)	# argv_ptr += 4
fff03360:	lwz     r4,0(r4)	# r4 = *r4
fff03364:	cmpwi   cr7,r4,0
fff03368:	bne+    cr7,_fff03318	# if (r4 != 0) goto _fff03318
		# null pointer
_fff0336c:	mr      r4,r28		# r4 = r28 = "(null)"
fff03370:	b       _fff03318	# goto _fff03318
		.endfunc


		# unused function
		# TODO maybe a syscall that waas inlined?
fff03374:	lbz     r0,0(r3)
fff03378:	extsb.  r0,r0
fff0337c:	beq-    _fff03394
		#
_fff03380:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03384:	stw     r0,REMOTE_CTRL_0054@l(r9)	# remote control: ROMMON variable
fff03388:	lbzu    r0,1(r3)
fff0338c:	extsb.  r0,r0
fff03390:	bne+    _fff03380
		#
_fff03394:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03398:	li      r0,2	# ROMMON_GET_VAR
fff0339c:	stw     r0,REMOTE_CTRL_0058@l(r9)	# remote control: ROMMON variable command
fff033a0:	li      r3,-1
fff033a4:	lwz     r0,REMOTE_CTRL_0058@l(r9)	# remote control: ROMMON variable command
fff033a8:	cmpwi   cr7,r0,0
fff033ac:	bnelr   cr7
fff033b0:	addic.  r0,r5,-1
fff033b4:	li      r11,0
fff033b8:	mtctr   r0
fff033bc:	ble-    _fff033fc
		#
_fff033c0:	lis     r10,REMOTE_CTRL_ADDRESS@h
fff033c4:	add     r9,r4,r11
fff033c8:	lwz     r0,REMOTE_CTRL_0054@l(r10)	# remote control: ROMMON variable
fff033cc:	extsb   r0,r0
fff033d0:	cmpwi   cr7,r0,0
fff033d4:	stbx    r0,r11,r4
fff033d8:	li      r0,0
fff033dc:	addi    r11,r11,1
fff033e0:	stb     r0,1(r9)
fff033e4:	beq-    cr7,_fff033ec
fff033e8:	bdnz+   _fff033c0
		#
_fff033ec:	li      r0,3
fff033f0:	li      r3,0
fff033f4:	stw     r0,REMOTE_CTRL_0058@l(r10)	# remote control: ROMMON variable command
fff033f8:	blr
		#
_fff033fc:	li      r0,1
fff03400:	mtctr   r0
fff03404:	b       _fff033c0
fff03408:	lbz     r0,0(r3)
fff0340c:	extsb.  r0,r0
fff03410:	beq-    _fff03428
		#
_fff03414:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03418:	stw     r0,REMOTE_CTRL_0054@l(r9)	# remote control: ROMMON variable
fff0341c:	lbzu    r0,1(r3)
fff03420:	extsb.  r0,r0
fff03424:	bne+    _fff03414
		#
_fff03428:	li      r0,1
fff0342c:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03430:	li      r3,0x800	# r3 = 0x800
fff03434:	stw     r0,REMOTE_CTRL_0058@l(r9)	# remote control: ROMMON variable command
fff03438:	blr	# return


		.func syscall
		.type _syscall, "function"
		# input: r3 = idx, r4 = a1, r5 = a2, r6 = a3, r7 = pc
		# output: r3 = ret
		# stack(32)
		# stack+4 =
		# stack+8 =
		# stack+12 =
		# stack+16 =
		# stack+20 = r29 (word)
		# stack+24 = r30 (word)
		# stack+28 = r31 (word)
		# stack+32
		# stack+36 = r0 (link register)
_syscall:
fff0343c:	cmplwi  cr7,r3,132
fff03440:	mflr    r0		# get link register
fff03444:	stwu    r1,-32(r1)	# reserve stack(32)
fff03448:	mr      r8,r4		# r8 = a1
fff0344c:	stw     r29,20(r1)	# save r29
fff03450:	mr      r29,r5		# r29 = a2
fff03454:	stw     r30,24(r1)	# save r30
fff03458:	mr      r30,r6		# r30 = a3
fff0345c:	stw     r31,28(r1)	# save r31
fff03460:	mr      r6,r7		# r6 = r7
fff03464:	stw     r0,36(r1)	# save r0 (link register)
fff03468:	ble-    cr7,_syscall_switch	# if (idx <= 132) goto _syscall_switch
		# default
		# prints error message to log and returns -1
_syscall_default:
fff0346c:	lis     r4,aUnhandledSyscall@h
fff03470:	mr      r5,r3
fff03474:	mr      r7,r8
fff03478:	addi    r4,r4,aUnhandledSyscall@l	# r4 = aUnhandledSyscall = "unhandled syscall 0x%x at pc=0x%x (a1=0x%x,a2=0x%x,a3=0x%x)\n"
fff0347c:	mr      r8,r29
fff03480:	mr      r9,r30
fff03484:	li      r3,1
fff03488:	crclr   4*cr1+eq
fff0348c:	bl      _fprintf	# _fprintf(1, "unhandled syscall 0x%x at pc=0x%x (a1=0x%x,a2=0x%x,a3=0x%x)\n", idx, pc, a1, a2, a3)
		# case 58
		# case 74
		# returns -1
_syscall_case_58:
_syscall_case_74:
fff03490:	li      r3,-1	# ret = -1
fff03494:	b       _syscall_end
		# switch (idx)
_syscall_switch:
fff03498:	lis     r9,_syscall_jmptbl@h
fff0349c:	rlwinm  r0,r3,2,0,29	# r0 = idx*4
fff034a0:	addi    r9,r9,_syscall_jmptbl@l
fff034a4:	lwzx    r11,r9,r0	# r11 = _syscall_jmptbl[idx]
fff034a8:	add     r11,r11,r9	# r11 = _syscall_jmptbl + r11
fff034ac:	mtctr   r11
fff034b0:	bctr	# goto r11
		# case 4
		# case 132
		# returns the RAM size in MiB
_syscall_case_4:
_syscall_case_132:
fff034b4:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff034b8:	lwz     r0,REMOTE_CTRL_0014@l(r9)	# remote control: RAM size
fff034bc:	rlwinm  r3,r0,20,0,11	# ret = (ram_size/0x100000)&0x7FF
		# end
_syscall_end:
fff034c0:	lwz     r0,36(r1)	# restore r0 (link register)
fff034c4:	lwz     r29,20(r1)	# restore r29
fff034c8:	lwz     r30,24(r1)	# restore r30
fff034cc:	mtlr    r0		# set link register
fff034d0:	lwz     r31,28(r1)	# restore r31
fff034d4:	addi    r1,r1,32	# restore stack
fff034d8:	blr	# return
		# case 44
		# copies cookie data to a1
		# returns 0
		# a1 = buffer (hword*)
_syscall_case_44:
fff034dc:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff034e0:	li      r0,0
fff034e4:	stw     r0,REMOTE_CTRL_004c@l(r9)	# remote control: Cookie position selector
fff034e8:	li      r10,1
fff034ec:	lwz     r0,REMOTE_CTRL_0050@l(r9)	# remote control: Cookie data
fff034f0:	li      r9,63
fff034f4:	mtctr   r9	# count register (CTR) = 63
fff034f8:	sth     r0,0(r4)	# *(hword*)a1 = (hword)cookie data
		# next cookie data hword
_fff034fc:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03500:	rlwinm  r11,r10,1,0,30	# r11 = r10*2
fff03504:	stw     r10,REMOTE_CTRL_004c@l(r9)	# remote control: Cookie position selector
fff03508:	addi    r10,r10,1
fff0350c:	lwz     r0,REMOTE_CTRL_0050@l(r9)	# remote control: Cookie data
fff03510:	sthx    r0,r8,r11	# *(hword*)(a1+r11) = (hword)cookie data
fff03514:	bdnz+   _fff034fc	# if (--CR != 0) goto _fff034fc
		# case 48
		# case 49
		# returns 0
_syscall_case_48:
_syscall_case_49:
fff03518:	lwz     r0,36(r1)	# restore r0 (link register)
fff0351c:	li      r3,0		# ret = 0
fff03520:	lwz     r29,20(r1)	# restore r29
fff03524:	lwz     r30,24(r1)	# restore r30
fff03528:	mtlr    r0		# set link register
fff0352c:	lwz     r31,28(r1)	# restore r31
fff03530:	addi    r1,r1,32	# restore stack
fff03534:	blr	# return
		# case 6
		# returns the complement of the config register
_syscall_case_6:
fff03538:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff0353c:	lwz     r0,REMOTE_CTRL_0024@l(r9)	# remote control: Config Register
fff03540:	not     r3,r0	# ret = ~(config register)
fff03544:	b       _syscall_end
		# case 1
		# prints character to console
		# returns 0
_syscall_case_1:
fff03548:	li      r3,0
fff0354c:	clrlwi  r4,r4,24	# r4 = (a1)&0xff
fff03550:	bl      _fputc	# _fputc(0, (a1)&0xff)
fff03554:	li      r3,0	# ret = 0
fff03558:	b       _syscall_end
		# case 46
		# reads bootvar a1 into the the buffer a2 (sizeof = a3)
		# the buffer will be NUL terminated
		# returns 0 on success, -1 on error
		# a1 = bootvar (const char*)
		# a2 = buffer (char*)
		# a3 = size of buffer (word)
_syscall_case_46:
fff0355c:	mr      r31,r4
fff03560:	lis     r4,aTryingToReadBootvar@h
fff03564:	addi    r4,r4,aTryingToReadBootvar@l	# r4 = "trying to read bootvar '%s'\n"
fff03568:	li      r3,1
fff0356c:	mr      r5,r8	# r5 = a1
fff03570:	crclr   4*cr1+eq
fff03574:	bl      _fprintf	# _fprintf(1, "trying to read bootvar '%s'\n", a1)
fff03578:	lbz     r0,0(r31)	# r31 = a1
fff0357c:	extsb.  r0,r0
fff03580:	beq-    _fff03598	# if (*a1 == 0) goto _fff03598
		# send bootvar name
_fff03584:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03588:	stw     r0,REMOTE_CTRL_0054@l(r9)	# remote control: ROMMON variable
fff0358c:	lbzu    r0,1(r31)	# ++r31
fff03590:	extsb.  r0,r0
fff03594:	bne+    _fff03584	# if (*r31 != 0) goto _fff03584
		# get value of bootvar
_fff03598:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff0359c:	li      r0,2	# ROMMON_GET_VAR
fff035a0:	stw     r0,REMOTE_CTRL_0058@l(r9)	# remote control: ROMMON variable command
fff035a4:	li      r3,-1	# ret = -1
fff035a8:	lwz     r0,REMOTE_CTRL_0058@l(r9)	# remote control: ROMMON variable command
fff035ac:	cmpwi   cr7,r0,0
fff035b0:	bne-    cr7,_syscall_end	# if (var_status != 0) goto _syscall_end
fff035b4:	addic.  r0,r30,-1	# r0 = a3-1
fff035b8:	li      r10,0	# r10 = 0
fff035bc:	mtctr   r0	# count register (CTR) = a3-1
fff035c0:	ble-    _fff037bc	# if (CR <= 0) goto _fff037bc
		# copy bootvar
_fff035c4:	lis     r8,REMOTE_CTRL_ADDRESS@h
fff035c8:	add     r11,r10,r29	# r11 = a2+r10
fff035cc:	lwz     r0,REMOTE_CTRL_0054@l(r8)	# remote control: ROMMON variable
fff035d0:	li      r9,0
fff035d4:	extsb   r0,r0
fff035d8:	cmpwi   cr7,r0,0
fff035dc:	stbx    r0,r29,r10	# r11[0] = r0
fff035e0:	stb     r9,1(r11)	# r11[1] = 0
fff035e4:	beq-    cr7,_fff035f0	# if (r0 == 0) goto _fff035f0
fff035e8:	addi    r10,r10,1	# ++r10
fff035ec:	bdnz+   _fff035c4	# if (--CR != 0) goto _fff035c4
		# finished copying bootvar
_fff035f0:	li      r0,3	# ROMMON_CLEAR_VAR_STAT
fff035f4:	li      r3,0	# ret = 0
fff035f8:	stw     r0,REMOTE_CTRL_0058@l(r8)	# remote control: ROMMON variable command
fff035fc:	b       _syscall_end
		# case 45
		# adds bootvar a1 using the format "varname=value"
		# returns 0x800
		# a1 = bootvar (const char*)
_syscall_case_45:
fff03600:	mr      r31,r4	# r31 = a1
fff03604:	lis     r4,aTryingToSetBootvar@h
fff03608:	addi    r4,r4,aTryingToSetBootvar@l	# r4 = "trying to set bootvar '%s'\n"
fff0360c:	li      r3,1
fff03610:	mr      r5,r8
fff03614:	crclr   4*cr1+eq
fff03618:	bl      _fprintf	# _fprintf(1, "trying to set bootvar '%s'\n", a1)
fff0361c:	lbz     r0,0(r31)
fff03620:	extsb.  r0,r0
fff03624:	beq-    _fff0363c	# if (*a1 == 0) goto _fff0363c
		# send bootvar
_fff03628:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff0362c:	stw     r0,REMOTE_CTRL_0054@l(r9)	# remote control: ROMMON variable
fff03630:	lbzu    r0,1(r31)	# ++r31
fff03634:	extsb.  r0,r0
fff03638:	bne+    _fff03628	# if (*r31 != 0) goto _fff03628
		# set bootvar
_fff0363c:	li      r0,1	# ROMMON_SET_VAR
fff03640:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03644:	li      r3,0x800	# ret = 0x800
fff03648:	stw     r0,REMOTE_CTRL_0058@l(r9)	# remote control: ROMMON variable command
fff0364c:	b       _syscall_end
		# case 43
		# stops the virtual machine
		# returns 0
_syscall_case_43:
fff03650:	li      r0,1
fff03654:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03658:	li      r3,0	# ret = 0
fff0365c:	stw     r0,REMOTE_CTRL_0034@l(r9)	# remote control: Stop the virtual machine
fff03660:	b       _syscall_end
		# case 37
		# copies a1 to the ios string in the nvram
		# returns 1
		# a1 = str (const char*)
_syscall_case_37:
fff03664:	lis     r9,_00004024@h
fff03668:	lwz     r3,_00004024@l(r9)
fff0366c:	bl      _strcpy	# _strcpy(nvram_ios, str)
fff03670:	li      r3,1	# ret = 1
fff03674:	b       _syscall_end
		# case 36
		# returns the bootldr string in nvram
_syscall_case_36:
fff03678:	lis     r9,_00004020@h
fff0367c:	lwz     r3,_00004020@l(r9)	# ret = _00004020
fff03680:	b       _syscall_end
		# case 35
		# copies a1 to the bootldr string in the nvram
		# returns 1
		# a1 = str (const char*)
_syscall_case_35:
fff03684:	lis     r9,_00004020@h
fff03688:	lwz     r3,_00004020@l(r9)
fff0368c:	bl      _strcpy	# _strcpy(nvram_bootldr, str)
fff03690:	li      r3,1	# ret = 1
fff03694:	b       _syscall_end
		# case 34
		# returns the ios string in nvram
_syscall_case_34:
fff03698:	lis     r9,_00004024@h
fff0369c:	lwz     r3,_00004024@l(r9)
fff036a0:	b       _syscall_end
		# case 28
		# return the config register
_syscall_case_28:
fff036a4:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff036a8:	lwz     r3,REMOTE_CTRL_0024@l(r9)	# remote control: Config Register
fff036ac:	b       _syscall_end
		# case 27
		# returns the IOMEM size in MiB
_syscall_case_27:
fff036b0:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff036b4:	lwz     r0,REMOTE_CTRL_0020@l(r9)	# remote control: IOMEM size
fff036b8:	rlwinm  r3,r0,20,0,11	# ret = iomem_size/0x100000
fff036bc:	b       _syscall_end
		# case 24
		# returns the NVRAM size in KiB
_syscall_case_24:
fff036c0:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff036c4:	lwz     r0,REMOTE_CTRL_001c@l(r9)	# remote control: NVRAM size
fff036c8:	rlwinm  r3,r0,10,0,21	# r3 = nvram_size/0x400
fff036cc:	b       _syscall_end
		# case 13
		# returns the address of nvram+0x780
_syscall_case_13:
fff036d0:	lis     r9,_00004028@h
fff036d4:	lwz     r3,_00004028@l(r9)	# ret = nvram+0x780
fff036d8:	b       _syscall_end
		# case 10
		# returns the address of _unk_string_array (array of strings with startup info?)
_syscall_case_10:
fff036dc:	lis     r9,_unk_string_array@h
fff036e0:	lwz     r3,_unk_string_array@l(r9)	# ret = _unk_string_array
fff036e4:	b       _syscall_end
		# case 8
		# request a reload and restarts IOS
		# stops the machine if the reload request fails
		# returns 0
_syscall_case_8:
fff036e8:	lis     r4,aROMReloadRequested@h
fff036ec:	li      r3,0
fff036f0:	addi    r4,r4,aROMReloadRequested@l	# r4 = "\n\nROM: reload requested...\n"
fff036f4:	lis     r31,REMOTE_CTRL_ADDRESS@h
fff036f8:	crclr   4*cr1+eq
fff036fc:	bl      _fprintf	# _fprintf(0, "\n\nROM: reload requested...\n")
fff03700:	lwz     r9,REMOTE_CTRL_0030@l(r31)	# remote control: Restart IOS Image
fff03704:	cmpwi   cr7,r9,0
fff03708:	beq-    cr7,_fff037a4	# if (r9 == 0) goto _fff037a4
fff0370c:	lis     r4,aROMRestartingIOS@h
fff03710:	li      r3,0
fff03714:	addi    r4,r4,aROMRestartingIOS@l	# r4 = "ROM: Restarting IOS...\n"
fff03718:	crclr   4*cr1+eq
fff0371c:	bl      _fprintf	# _fprintf(0, "ROM: Restarting IOS...\n")
fff03720:	lwz     r3,REMOTE_CTRL_0028@l(r31)	# remote control: ELF entry point
fff03724:	bl      _restart_image	# _restart_image(r3)
fff03728:	li      r3,0	# ret = 0
fff0372c:	b       _syscall_end
		# case 7
		# returns the ELF machine id
_syscall_case_7:
fff03730:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03734:	lwz     r3,REMOTE_CTRL_002c@l(r9)	# remote control: ELF machine id
fff03738:	b       _syscall_end
		# case 55
		# returns 0x380
_syscall_case_55:
fff0373c:	li      r3,0x380
fff03740:	b       _syscall_end
		# case 47
		# returns 0x800
_syscall_case_47:
fff03744:	li      r3,0x800
fff03748:	b       _syscall_end
		# case 60
		# returns the IO memory size
		# TODO describe nvram and 0x8000 restictions
		# returns the IO memory size
_syscall_case_60:
fff0374c:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03750:	lwz     r0,REMOTE_CTRL_0048@l(r9)	# remote control: IO memory size for Smart-Init (C3600, others ?)
fff03754:	andi.   r11,r0,0x8000	# r11 = (r0)&0x8000
fff03758:	rlwinm  r3,r0,0,17,15	# ret = (r0)&0x38000
fff0375c:	bne-    _syscall_end	# if (r11 != 0) goto _syscall_end
fff03760:	lwz     r9,REMOTE_CTRL_0044@l(r9)	# remote control: NVRAM address
fff03764:	lwz     r3,0x7e0(r9)	# ret = *(nvram+0x7E0) # TODO check what's there
fff03768:	cmpwi   cr7,r3,0
fff0376c:	bne-    cr7,_syscall_end # if (*(nvram+0x7e0) != 0) goto _syscall_end
fff03770:	rlwinm  r3,r0,0,17,15	# ret = (r0)&0x38000
fff03774:	b       _syscall_end
		# case 2
		# returns 0xc00
_syscall_case_2:
fff03778:	li      r3,0xC00
fff0377c:	b       _syscall_end
		# case 54
		# returns the address nvram+0x400 (nvram filesystem?)
_syscall_case_54:
fff03780:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03784:	lwz     r11,REMOTE_CTRL_0044@l(r9)	# remote control: NVRAM address
fff03788:	addi    r3,r11,0x400
fff0378c:	b       _syscall_end
		# case 59
		# sets the address nvram+0x7E0 to a1
		# a1 = ??? (word)
_syscall_case_59:
fff03790:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03794:	li      r3,1
fff03798:	lwz     r11,REMOTE_CTRL_0044@l(r9)	# remote control: NVRAM address
fff0379c:	stw     r4,0x7E0(r11)	# *(nvram+0x7E0) = a1 # TODO check what's there
fff037a0:	b       _syscall_end
		# stop the virtual machine
_fff037a4:	li      r0,1
fff037a8:	mtctr   r9	# count register = r9 = 0
fff037ac:	stw     r0,REMOTE_CTRL_0034@l(r31)	# remote control: Stop the virtual machine
fff037b0:	bctrl	# call count register - forced crash
fff037b4:	li      r3,0	# ret = 0
fff037b8:	b       _syscall_end
		# minimum count register of bootvar buffer
_fff037bc:	li      r9,1
fff037c0:	mtctr   r9	# count register = 1
fff037c4:	b       _fff035c4
		.endfunc


		.func fputc
		.type _fputc, "function"
		# similar to putc
		# input: r3 = stream (0-console,!0-log), r4 = character
		# output:
_fputc:
fff037c8:	cmpwi   cr7,r3,0
fff037cc:	bne-    cr7,_fff037dc
fff037d0:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff037d4:	stw     r4,REMOTE_CTRL_0040@l(r9)	# r4 = 0xf6000040  # remote control: console output
fff037d8:	blr			# return
		# stream != 0
_fff037dc:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff037e0:	stw     r4,REMOTE_CTRL_003c@l(r9)	# r4 = 0xf600003c  # remote control: console buffering
fff037e4:	blr			# return
		.endfunc


		.func fputs
		.type _fputs, "function"
		# similar to fputs
		# input: r3 = stream (0-console,!0-log), r4 = str
		# output:
_fputs:
fff037e8:	lbz     r0,0(r4)
fff037ec:	cmpwi   cr7,r0,0
fff037f0:	beqlr   cr7	# if (*str == 0) return
fff037f4:	cmpwi   cr7,r3,0
fff037f8:	beq-    cr7,_fff03828	# if (stream == 0) goto _fff03828
		# write to log
_fff037fc:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03800:	stw     r0,REMOTE_CTRL_003c@l(r9)	# remote control: console buffering
fff03804:	lbzu    r0,1(r4)	# r0 = *(++str)
fff03808:	cmpwi   cr7,r0,0
fff0380c:	beqlr   cr7	# if (r0 == 0) return
fff03810:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff03814:	stw     r0,REMOTE_CTRL_003c@l(r9)	# remote control: console buffering
fff03818:	lbzu    r0,1(r4)	# r0 = *(++str)
fff0381c:	cmpwi   cr7,r0,0
fff03820:	bne+    cr7,_fff037fc	# if (r0 != 0) goto _fff037fc
fff03824:	blr	# return
		# write to console
_fff03828:	lis     r9,REMOTE_CTRL_ADDRESS@h
fff0382c:	stw     r0,REMOTE_CTRL_0040@l(r9)	# remote control: console output
fff03830:	lbzu    r0,1(r4)	# r0 = *(++str)
fff03834:	cmpwi   cr7,r0,0
fff03838:	bne+    cr7,_fff03828	# if (r0 != 0) goto _fff03828
fff0383c:	blr	# return
		.endfunc


		# unused function
fff03840:	mflr    r0
fff03844:	stwu    r1,-16(r1)
fff03848:	stw     r0,20(r1)
fff0384c:	li      r0,0
fff03850:	mtctr   r0
fff03854:	bctrl
fff03858:	lwz     r0,20(r1)
fff0385c:	addi    r1,r1,16
fff03860:	mtlr    r0
fff03864:	blr


		.func main
		.type _main, "function"
		# main function
		# input:
		# output:
		# stack(32)
		# stack+4 =
		# stack+8 =
		# stack+12 =
		# stack+16 =
		# stack+20 = r29 (word)
		# stack+24 =
		# stack+28 = r31 (word)
		# stack+32
		# stack+36 = r0 (link register)
_main:
fff03868:	mflr    r0		# get link register
fff0386c:	stwu    r1,-32(r1)	# reserve stack space
fff03870:	lis     r4,aROMMONEmulationMicrocode@h
fff03874:	li      r3,0
fff03878:	addi    r4,r4,aROMMONEmulationMicrocode@l	# r4 = "ROMMON emulation microcode.\n\n"
fff0387c:	stw     r31,28(r1)	# save r31
fff03880:	stw     r0,36(r1)	# save r0 (link register)
fff03884:	lis     r31,REMOTE_CTRL_ADDRESS@h
fff03888:	stw     r29,20(r1)	# save r29
fff0388c:	crclr   4*cr1+eq
fff03890:	bl      _fprintf	# _fprintf(0, "ROMMON emulation microcode.\n\n")
fff03894:	lis     r4,aMicrocodeHasStarted@h
fff03898:	li      r3,1
fff0389c:	addi    r4,r4,aMicrocodeHasStarted@l	# r4 = "Microcode has started.\n"
fff038a0:	crclr   4*cr1+eq
fff038a4:	bl      _fprintf	# _fprintf(1, "Microcode has started.\n")
fff038a8:	lwz     r9,REMOTE_CTRL_0000@l(r31)	# remote control: ROM Identification tag
fff038ac:	xoris   r0,r9,~ROM_ID@h
fff038b0:	cmpwi   cr7,r0,ROM_ID@l
fff038b4:	beq-    cr7,_fff038d8	# if (rom_id != ROM_ID) goto _fff038d8
fff038b8:	lis     r4,aTheMicrocodeNeedToBeUpgraded@h
fff038bc:	li      r3,0
fff038c0:	addi    r4,r4,aTheMicrocodeNeedToBeUpgraded@l	# r4 = "The microcode need to be upgraded to match your emulator version.\n"
fff038c4:	crclr   4*cr1+eq
fff038c8:	bl      _fprintf	# _fprintf(0, "The microcode need to be upgraded to match your emulator version.\n")
fff038cc:	li      r0,0
fff038d0:	mtctr   r0	# Count Register (CTR) = 0
fff038d4:	bctrl		# goto Count Register - forced crash
		# ROM_ID is ok
_fff038d8:	lwz     r29,REMOTE_CTRL_0044@l(r31)	# remote control: NVRAM address
fff038dc:	lis     r4,aIOS@h
fff038e0:	lis     r9,_00004024@h
fff038e4:	addi    r4,r4,aIOS@l	# r4 = "IOS"
fff038e8:	addi    r0,r29,0x80
fff038ec:	mr      r3,r0
fff038f0:	stw     r0,_00004024@l(r9)
fff038f4:	bl      _strcpy	# _strcpy(nvram+0x80, "IOS")
fff038f8:	addi    r0,r29,0x200
fff038fc:	lis     r4,aBOOTLDR@h
fff03900:	lis     r9,_00004020@h
fff03904:	mr      r3,r0
fff03908:	addi    r4,r4,aBOOTLDR@l	# r4 = "BOOTLDR"
fff0390c:	stw     r0,_00004020@l(r9)
fff03910:	addi    r29,r29,0x780
fff03914:	bl      _strcpy	# _strcpy(nvram+0x200, "BOOTLDR")
fff03918:	lis     r9,_00004028@h
fff0391c:	lis     r11,aLaunchingIOSImageAt@h
fff03920:	stw     r29,_00004028@l(r9)
fff03924:	addi    r31,r11,aLaunchingIOSImageAt@l	# r31 = "Launching IOS image at 0x%x...\n"
		# launch image
_fff03928:	lis     r29,REMOTE_CTRL_ADDRESS@h
fff0392c:	mr      r4,r31
fff03930:	lwz     r5,REMOTE_CTRL_0028@l(r29)	# remote control: ELF entry point
fff03934:	li      r3,0
fff03938:	crclr   4*cr1+eq
fff0393c:	bl      _fprintf	# _fprintf(0, "Launching IOS image at 0x%x...\n")
fff03940:	lwz     r3,REMOTE_CTRL_0028@l(r29)	# remote control: ELF entry point
fff03944:	bl      _launch_image	# _launch_image(elf_entry_point)
fff03948:	lwz     r0,REMOTE_CTRL_0030@l(r29)	# Restart IOS Image
fff0394c:	cmpwi   cr7,r0,0
fff03950:	bne+    cr7,_fff03928	# if (restart_ios_image != 0) then launch image again
fff03954:	lis     r4,aImageReturnedToROM@h
fff03958:	li      r3,0
fff0395c:	addi    r4,r4,aImageReturnedToROM@l	# r4 = "Image returned to ROM.\n"
fff03960:	crclr   4*cr1+eq
fff03964:	bl      _fprintf	# _fprintf(0, "Image returned to ROM.\n")
fff03968:	li      r0,1
fff0396c:	stw     r0,REMOTE_CTRL_0034@l(r29)	# remote control: Stop the virtual machine
fff03970:	lwz     r0,36(r1)	# restore r0 (link register)
fff03974:	lwz     r29,20(r1)	# restore r29
fff03978:	lwz     r31,28(r1)	# restore r31
fff0397c:	mtlr    r0		# restore link register
fff03980:	addi    r1,r1,32	# restore stack
fff03984:	blr	# return
		.endfunc
		.org 0x3fff, 0
		.byte 0


		##############################
		# read-only data
		# address = 0xfff04000
		# size = 0x220
		.section .rodata
		.align 2
_syscall_jmptbl:
fff04000:	.long _syscall_default	- _syscall_jmptbl # 0
fff04004:	.long _syscall_case_1	- _syscall_jmptbl
fff04008:	.long _syscall_case_2	- _syscall_jmptbl
fff0400c:	.long _syscall_default	- _syscall_jmptbl
fff04010:	.long _syscall_case_4	- _syscall_jmptbl
fff04014:	.long _syscall_default	- _syscall_jmptbl
fff04018:	.long _syscall_case_6	- _syscall_jmptbl
fff0401c:	.long _syscall_case_7	- _syscall_jmptbl
fff04020:	.long _syscall_case_8	- _syscall_jmptbl
fff04024:	.long _syscall_default	- _syscall_jmptbl
fff04028:	.long _syscall_case_10  - _syscall_jmptbl # 10
fff0402c:	.long _syscall_default	- _syscall_jmptbl
fff04030:	.long _syscall_default	- _syscall_jmptbl
fff04034:	.long _syscall_case_13	- _syscall_jmptbl
fff04038:	.long _syscall_default	- _syscall_jmptbl
fff0403c:	.long _syscall_default	- _syscall_jmptbl
fff04040:	.long _syscall_default	- _syscall_jmptbl
fff04044:	.long _syscall_default	- _syscall_jmptbl
fff04048:	.long _syscall_default	- _syscall_jmptbl
fff0404c:	.long _syscall_default	- _syscall_jmptbl
fff04050:	.long _syscall_default	- _syscall_jmptbl # 20
fff04054:	.long _syscall_default	- _syscall_jmptbl
fff04058:	.long _syscall_default	- _syscall_jmptbl
fff0405c:	.long _syscall_default	- _syscall_jmptbl
fff04060:	.long _syscall_case_24	- _syscall_jmptbl
fff04064:	.long _syscall_default	- _syscall_jmptbl
fff04068:	.long _syscall_default	- _syscall_jmptbl
fff0406c:	.long _syscall_case_27	- _syscall_jmptbl
fff04070:	.long _syscall_case_28	- _syscall_jmptbl
fff04074:	.long _syscall_default	- _syscall_jmptbl
fff04078:	.long _syscall_default	- _syscall_jmptbl # 30
fff0407c:	.long _syscall_default	- _syscall_jmptbl
fff04080:	.long _syscall_default	- _syscall_jmptbl
fff04084:	.long _syscall_default	- _syscall_jmptbl
fff04088:	.long _syscall_case_34	- _syscall_jmptbl
fff0408c:	.long _syscall_case_35	- _syscall_jmptbl
fff04090:	.long _syscall_case_36	- _syscall_jmptbl
fff04094:	.long _syscall_case_37	- _syscall_jmptbl
fff04098:	.long _syscall_default	- _syscall_jmptbl
fff0409c:	.long _syscall_default	- _syscall_jmptbl
fff040a0:	.long _syscall_default	- _syscall_jmptbl # 40
fff040a4:	.long _syscall_default	- _syscall_jmptbl
fff040a8:	.long _syscall_default	- _syscall_jmptbl
fff040ac:	.long _syscall_case_43	- _syscall_jmptbl
fff040b0:	.long _syscall_case_44	- _syscall_jmptbl
fff040b4:	.long _syscall_case_45	- _syscall_jmptbl
fff040b8:	.long _syscall_case_46	- _syscall_jmptbl
fff040bc:	.long _syscall_case_47	- _syscall_jmptbl
fff040c0:	.long _syscall_case_48	- _syscall_jmptbl
fff040c4:	.long _syscall_case_49	- _syscall_jmptbl
fff040c8:	.long _syscall_default	- _syscall_jmptbl # 50
fff040cc:	.long _syscall_default	- _syscall_jmptbl
fff040d0:	.long _syscall_default	- _syscall_jmptbl
fff040d4:	.long _syscall_default	- _syscall_jmptbl
fff040d8:	.long _syscall_case_54	- _syscall_jmptbl
fff040dc:	.long _syscall_case_55	- _syscall_jmptbl
fff040e0:	.long _syscall_default	- _syscall_jmptbl
fff040e4:	.long _syscall_default	- _syscall_jmptbl
fff040e8:	.long _syscall_case_58	- _syscall_jmptbl
fff040ec:	.long _syscall_case_59	- _syscall_jmptbl
fff040f0:	.long _syscall_case_60	- _syscall_jmptbl # 60
fff040f4:	.long _syscall_default	- _syscall_jmptbl
fff040f8:	.long _syscall_default	- _syscall_jmptbl
fff040fc:	.long _syscall_default	- _syscall_jmptbl
fff04100:	.long _syscall_default	- _syscall_jmptbl
fff04104:	.long _syscall_default	- _syscall_jmptbl
fff04108:	.long _syscall_default	- _syscall_jmptbl
fff0410c:	.long _syscall_default	- _syscall_jmptbl
fff04110:	.long _syscall_default	- _syscall_jmptbl
fff04114:	.long _syscall_default	- _syscall_jmptbl
fff04118:	.long _syscall_default	- _syscall_jmptbl # 70
fff0411c:	.long _syscall_default	- _syscall_jmptbl
fff04120:	.long _syscall_default	- _syscall_jmptbl
fff04124:	.long _syscall_default	- _syscall_jmptbl
fff04128:	.long _syscall_case_74	- _syscall_jmptbl
fff0412c:	.long _syscall_default	- _syscall_jmptbl
fff04130:	.long _syscall_default	- _syscall_jmptbl
fff04134:	.long _syscall_default	- _syscall_jmptbl
fff04138:	.long _syscall_default	- _syscall_jmptbl
fff0413c:	.long _syscall_default	- _syscall_jmptbl
fff04140:	.long _syscall_default	- _syscall_jmptbl # 80
fff04144:	.long _syscall_default	- _syscall_jmptbl
fff04148:	.long _syscall_default	- _syscall_jmptbl
fff0414c:	.long _syscall_default	- _syscall_jmptbl
fff04150:	.long _syscall_default	- _syscall_jmptbl
fff04154:	.long _syscall_default	- _syscall_jmptbl
fff04158:	.long _syscall_default	- _syscall_jmptbl
fff0415c:	.long _syscall_default	- _syscall_jmptbl
fff04160:	.long _syscall_default	- _syscall_jmptbl
fff04164:	.long _syscall_default	- _syscall_jmptbl
fff04168:	.long _syscall_default	- _syscall_jmptbl # 90
fff0416c:	.long _syscall_default	- _syscall_jmptbl
fff04170:	.long _syscall_default	- _syscall_jmptbl
fff04174:	.long _syscall_default	- _syscall_jmptbl
fff04178:	.long _syscall_default	- _syscall_jmptbl
fff0417c:	.long _syscall_default	- _syscall_jmptbl
fff04180:	.long _syscall_default	- _syscall_jmptbl
fff04184:	.long _syscall_default	- _syscall_jmptbl
fff04188:	.long _syscall_default	- _syscall_jmptbl
fff0418c:	.long _syscall_default	- _syscall_jmptbl
fff04190:	.long _syscall_default	- _syscall_jmptbl # 100
fff04194:	.long _syscall_default	- _syscall_jmptbl
fff04198:	.long _syscall_default	- _syscall_jmptbl
fff0419c:	.long _syscall_default	- _syscall_jmptbl
fff041a0:	.long _syscall_default	- _syscall_jmptbl
fff041a4:	.long _syscall_default	- _syscall_jmptbl
fff041a8:	.long _syscall_default	- _syscall_jmptbl
fff041ac:	.long _syscall_default	- _syscall_jmptbl
fff041b0:	.long _syscall_default	- _syscall_jmptbl
fff041b4:	.long _syscall_default	- _syscall_jmptbl
fff041b8:	.long _syscall_default	- _syscall_jmptbl # 110
fff041bc:	.long _syscall_default	- _syscall_jmptbl
fff041c0:	.long _syscall_default	- _syscall_jmptbl
fff041c4:	.long _syscall_default	- _syscall_jmptbl
fff041c8:	.long _syscall_default	- _syscall_jmptbl
fff041cc:	.long _syscall_default	- _syscall_jmptbl
fff041d0:	.long _syscall_default	- _syscall_jmptbl
fff041d4:	.long _syscall_default	- _syscall_jmptbl
fff041d8:	.long _syscall_default	- _syscall_jmptbl
fff041dc:	.long _syscall_default	- _syscall_jmptbl
fff041e0:	.long _syscall_default	- _syscall_jmptbl # 120
fff041e4:	.long _syscall_default	- _syscall_jmptbl
fff041e8:	.long _syscall_default	- _syscall_jmptbl
fff041ec:	.long _syscall_default	- _syscall_jmptbl
fff041f0:	.long _syscall_default	- _syscall_jmptbl
fff041f4:	.long _syscall_default	- _syscall_jmptbl
fff041f8:	.long _syscall_default	- _syscall_jmptbl
fff041fc:	.long _syscall_default	- _syscall_jmptbl
fff04200:	.long _syscall_default	- _syscall_jmptbl
fff04204:	.long _syscall_default	- _syscall_jmptbl
fff04208:	.long _syscall_default	- _syscall_jmptbl # 130
fff0420c:	.long _syscall_default	- _syscall_jmptbl
fff04210:	.long _syscall_case_132	- _syscall_jmptbl
fff04214:	.long 0x00000000
fff04218:	.long 0x00000000
fff0421c:	.long 0x00000000


		# read-only string data
		# address = 0xfff04220
		# size = 0x00000198
		.section .rodata.str1.4
		.align 2
aNull:
fff04220:	.string "(null)"
		.balign 4
aROMReloadRequested:
fff04228:	.string "\n\nROM: reload requested...\n"
		.balign 4
aROMRestartingIOS:
fff04244:	.string "ROM: Restarting IOS...\n"
		.balign 4
aTryingToReadBootvar:
fff0425C:	.string "trying to read bootvar '%s'\n"
		.balign 4
aTryingToSetBootvar:
fff0427C:	.string "trying to set bootvar '%s'\n"
		.balign 4
aUnhandledSyscall:
fff04298:	.string "unhandled syscall 0x%x at pc=0x%x (a1=0x%x,a2=0x%x,a3=0x%x)\n"
		.balign 4
a__ROMMONEmulationMicrocode:
fff042d8:	.string "\n\nROMMON Emulation Microcode\n"
		.balign 4
aROMMONEmulationMicrocode:
fff042f8:	.string "ROMMON emulation microcode.\n\n"
		.balign 4
aMicrocodeHasStarted:
fff04318:	.string "Microcode has started.\n"
		.balign 4
aTheMicrocodeNeedToBeUpgraded:
fff04330:	.string "The microcode need to be upgraded to match your emulator version.\n"
		.balign 4
aIOS:
fff04374:	.string "IOS"
		.balign 4
aBOOTLDR:
fff04378:	.string "BOOTLDR"
		.balign 4
aLaunchingIOSImageAt:
fff04380:	.string "Launching IOS image at 0x%x...\n"
		.balign 4
aImageReturnedToROM:
fff043a0:	.string "Image returned to ROM.\n"
		.balign 4


		# read-write data
		# address = 0xfff043b8
		# size = 8
		.section .data
		.align 2
_unk_string_array:
fff043b8:	.long a__ROMMONEmulationMicrocode
fff043bc:	.long 0x00000000



		##############################
		# alloc data
		# address = 0x00004000
		# size = 0x40
		.section .bss
		.align 4
		# syscall exceptions:
_00004000:	.long 0	# saved r8
_00004004:	.long 0	# saved r9
_00004008:	.long 0	# saved SPRG1
_0000400c:	.long 0	# saved link register
_00004010:	.long 0 # saved XER register
_00004014:	.long 0	# saved count register
		# TODO
_00004018:	.long 0
_0000401c:	.long 0
_00004020:	.long 0	# = nvram+0x200 ("BOOTLDR")
_00004024:	.long 0	# = nvram+0x80 ("IOS")
_00004028:	.long 0	# = nvram+0x780
_0000402c:	.long 0
_00004030:	.long 0
_00004034:	.long 0
_00004038:	.long 0
_0000403c:	.long 0



		##############################
		# comments
		# address = 0x00000000
		# size = 0x48
		.section .comment
		.align 0
		.ascii "\0GCC: (GNU) 4.2.0\0"
		.ascii "\0GCC: (GNU) 4.2.0\0"
		.ascii "\0GCC: (GNU) 4.2.0\0"
		.ascii "\0GCC: (GNU) 4.2.0\0"
