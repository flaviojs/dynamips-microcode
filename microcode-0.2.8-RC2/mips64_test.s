# Reference for interrupts and exceptions:
# MIPs64® Architecture For Programmers Volume III: The MIPs64® Privileged Resource Architecture
# Document Number: MD00091
# Revision 2.50
# July 1, 2005


#
# mips64_microcode:     file format elf32-bigmips
#

	# options
	.set noreorder # NOTE: branch/jump instructions (all?) are delayed until the next instruction is complete (more on some cases?)

	# registers
	.set c0_badvaddr, $8 # BadVAddr - Reports the address for the most recent address-related exception
	.set c0_count, $9 # Count - Processor cycle count
	.set c0_compare, $11 # Compare - Timer interrupt control
	.set c0_sr, $12 # Status - Processor status and control
	.set c0_cause, $13 # Cause - Cause of last general exception
	.set c0_epc, $14 # EPC - Program counter at last exception
	.set c0_errorepc, $30 # ErrorEPC - Program counter at last error

	# memory addresses
	.set RESTART_SP, 0x80004000
	# custom remote control device
	.set REMOTE_CTRL,                         0xb6000000
	.set REMOTE_CTRL_rom_id,                  0xb6000000
	.set REMOTE_CTRL_cpu_id,                  0xb6000004
	.set REMOTE_CTRL_display_cpu_registers,   0xb6000008
	.set REMOTE_CTRL_display_cpu_memory_info, 0xb600000c
	.set REMOTE_CTRL_unused_0010,             0xb6000010
	.set REMOTE_CTRL_ram_size,                0xb6000014
	.set REMOTE_CTRL_rom_size,                0xb6000018
	.set REMOTE_CTRL_nvram_size,              0xb600001c
	.set REMOTE_CTRL_iomem_size,              0xb6000020
	.set REMOTE_CTRL_config_reg,              0xb6000024
	.set REMOTE_CTRL_elf_entry_point,         0xb6000028
	.set REMOTE_CTRL_elf_machine_id,          0xb600002c
	.set REMOTE_CTRL_restart_ios,             0xb6000030
	.set REMOTE_CTRL_stop_virtual_machine,    0xb6000034
	.set REMOTE_CTRL_debug_message,           0xb6000038
	.set REMOTE_CTRL_log_output,              0xb600003c
	.set REMOTE_CTRL_console_output,          0xb6000040
	.set REMOTE_CTRL_nvram_address,           0xb6000044
	.set REMOTE_CTRL_io_memory_size,          0xb6000048
	.set REMOTE_CTRL_cookie_position,         0xb600004c
	.set REMOTE_CTRL_cookie_data,             0xb6000050
	.set REMOTE_CTRL_rommon_variable,         0xb6000054
	.set REMOTE_CTRL_rommon_variable_command, 0xb6000058


	#############################################################
	.text
	.align 3
	.globl _start
_start:
_bfc00000:	jal	start_microcode
bfc00004:	nop
bfc00008:	jr	$zero
bfc0000c:	nop

	.org 0x200, 0
bfc00200:	addiu	$sp,$sp,-512
bfc00204:	sd	$k0,208($sp)
bfc00208:	sd	$k1,216($sp)
bfc0020c:	addiu	$k0,$sp,512
bfc00210:	sd	$k0,232($sp)
bfc00214:	sd	$ra,248($sp)
bfc00218:	lui	$k0,%hi(_bfc003e0)
bfc0021c:	addiu	$k0,$k0,%lo(_bfc003e0)
bfc00220:	lui	$k1,%hi(_bfc00810)
bfc00224:	addiu	$k1,$k1,%lo(_bfc00810)
bfc00228:	jr	$k0
bfc0022c:	nop

	.org 0x280, 0
bfc00280:	addiu	$sp,$sp,-512
bfc00284:	sd	$k0,208($sp)
bfc00288:	sd	$k1,216($sp)
bfc0028c:	addiu	$k0,$sp,512
bfc00290:	sd	$k0,232($sp)
bfc00294:	sd	$ra,248($sp)
bfc00298:	lui	$k0,%hi(_bfc003e0)
bfc0029c:	addiu	$k0,$k0,%lo(_bfc003e0)
bfc002a0:	lui	$k1,%hi(_bfc00810)
bfc002a4:	addiu	$k1,$k1,%lo(_bfc00810)
bfc002a8:	jr	$k0
bfc002ac:	nop

	.org 0x300, 0
bfc00300:	addiu	$sp,$sp,-512
bfc00304:	sd	$k0,208($sp)
bfc00308:	sd	$k1,216($sp)
bfc0030c:	addiu	$k0,$sp,512
bfc00310:	sd	$k0,232($sp)
bfc00314:	sd	$ra,248($sp)
bfc00318:	lui	$k0,%hi(_bfc003e0)
bfc0031c:	addiu	$k0,$k0,%lo(_bfc003e0)
bfc00320:	lui	$k1,%hi(_bfc008d0)
bfc00324:	addiu	$k1,$k1,%lo(_bfc008d0)
bfc00328:	jr	$k0
bfc0032c:	nop

	.org 0x380, 0
bfc00380:	addiu	$sp,$sp,-512
bfc00384:	sd	$k0,208($sp)
bfc00388:	sd	$k1,216($sp)
bfc0038c:	addiu	$k0,$sp,512
bfc00390:	sd	$k0,232($sp)
bfc00394:	sd	$ra,248($sp)
bfc00398:	lui	$k0,%hi(_bfc003e0)
bfc0039c:	addiu	$k0,$k0,%lo(_bfc003e0)
bfc003a0:	lui	$k1,%hi(_bfc00810)
bfc003a4:	addiu	$k1,$k1,%lo(_bfc00810)
bfc003a8:	jr	$k0
bfc003ac:	nop

_bfc003b0:	addiu	$sp,$sp,-512
bfc003b4:	sd	$k0,208($sp)
bfc003b8:	sd	$k1,216($sp)
bfc003bc:	addiu	$k0,$sp,512
bfc003c0:	sd	$k0,232($sp)
bfc003c4:	sd	$ra,248($sp)
bfc003c8:	lui	$k0,%hi(_bfc003e0)
bfc003cc:	addiu	$k0,$k0,%lo(_bfc003e0)
bfc003d0:	lui	$k1,%hi(_bfc00810)
bfc003d4:	addiu	$k1,$k1,%lo(_bfc00810)
bfc003d8:	jr	$k0
bfc003dc:	nop

	.set noat
_bfc003e0:	sd	$at,8($sp)
	.set at
bfc003e4:	sd	$v0,16($sp)
bfc003e8:	sd	$v1,24($sp)
bfc003ec:	sd	$a0,32($sp)
bfc003f0:	sd	$a1,40($sp)
bfc003f4:	sd	$a2,48($sp)
bfc003f8:	sd	$a3,56($sp)
bfc003fc:	sd	$t0,64($sp)
bfc00400:	sd	$t1,72($sp)
bfc00404:	sd	$t2,80($sp)
bfc00408:	sd	$t3,88($sp)
bfc0040c:	sd	$t4,96($sp)
bfc00410:	sd	$t5,104($sp)
bfc00414:	sd	$t6,112($sp)
bfc00418:	sd	$t7,120($sp)
bfc0041c:	sd	$s0,128($sp)
bfc00420:	sd	$s1,136($sp)
bfc00424:	sd	$s2,144($sp)
bfc00428:	sd	$s3,152($sp)
bfc0042c:	sd	$s4,160($sp)
bfc00430:	sd	$s5,168($sp)
bfc00434:	sd	$s6,176($sp)
bfc00438:	sd	$s7,184($sp)
bfc0043c:	sd	$t8,192($sp)
bfc00440:	sd	$t9,200($sp)
bfc00444:	sd	$gp,224($sp)
bfc00448:	sd	$s8,240($sp)
bfc0044c:	sd	$ra,248($sp)
bfc00450:	mfhi	$a0
bfc00454:	mflo	$a1
bfc00458:	sd	$a0,272($sp)
bfc0045c:	sd	$a1,264($sp)
bfc00460:	mfc0	$a0,c0_sr
bfc00464:	sw	$a0,256($sp)
bfc00468:	mfc0	$a0,c0_cause
bfc0046c:	sw	$a0,288($sp)
bfc00470:	dmfc0	$a1,c0_badvaddr
bfc00474:	sd	$a1,280($sp)
bfc00478:	dmfc0	$a2,c0_epc
bfc0047c:	sd	$a2,296($sp)
bfc00480:	dmfc0	$a3,c0_errorepc
bfc00484:	sd	$a3,304($sp)
bfc00488:	move	$a0,$sp
bfc0048c:	jalr	$k1
bfc00490:	nop
bfc00494:	lw	$a0,256($sp)
bfc00498:	mtc0	$a0,c0_sr
bfc0049c:	ld	$a0,296($sp)
bfc004a0:	dmtc0	$a0,c0_epc
bfc004a4:	nop
bfc004a8:	ld	$a1,304($sp)
bfc004ac:	dmtc0	$a1,c0_errorepc
bfc004b0:	nop
bfc004b4:	ld	$a0,272($sp)
bfc004b8:	ld	$a1,264($sp)
bfc004bc:	mthi	$a0
bfc004c0:	mtlo	$a1
bfc004c4:	ld	$k1,216($sp)
	.set noat
bfc004c8:	ld	$at,8($sp)
	.set at
bfc004cc:	ld	$v0,16($sp)
bfc004d0:	ld	$v1,24($sp)
bfc004d4:	ld	$a0,32($sp)
bfc004d8:	ld	$a1,40($sp)
bfc004dc:	ld	$a2,48($sp)
bfc004e0:	ld	$a3,56($sp)
bfc004e4:	ld	$t0,64($sp)
bfc004e8:	ld	$t1,72($sp)
bfc004ec:	ld	$t2,80($sp)
bfc004f0:	ld	$t3,88($sp)
bfc004f4:	ld	$t4,96($sp)
bfc004f8:	ld	$t5,104($sp)
bfc004fc:	ld	$t6,112($sp)
bfc00500:	ld	$t7,120($sp)
bfc00504:	ld	$s0,128($sp)
bfc00508:	ld	$s1,136($sp)
bfc0050c:	ld	$s2,144($sp)
bfc00510:	ld	$s3,152($sp)
bfc00514:	ld	$s4,160($sp)
bfc00518:	ld	$s5,168($sp)
bfc0051c:	ld	$s6,176($sp)
bfc00520:	ld	$s7,184($sp)
bfc00524:	ld	$t8,192($sp)
bfc00528:	ld	$t9,200($sp)
bfc0052c:	ld	$gp,224($sp)
bfc00530:	ld	$s8,240($sp)
bfc00534:	ld	$ra,248($sp)
bfc00538:	ld	$sp,232($sp)
bfc0053c:	nop
bfc00540:	eret
bfc00544:	nop

_bfc00548:	.word _bfc003b0
bfc0054c:	.word _bfc003e0
bfc00550:	.word _bfc003e0
bfc00554:	.word _bfc003e0
bfc00558:	.word _bfc003e0
bfc0055c:	.word _bfc003e0
bfc00560:	.word _bfc003e0
bfc00564:	.word _bfc003e0
bfc00568:	.word _bfc003b0
bfc0056c:	.word _bfc003e0
bfc00570:	.word _bfc003e0
bfc00574:	.word _bfc003e0
bfc00578:	.word _bfc003e0
bfc0057c:	.word _bfc003e0
bfc00580:	.word _bfc003e0
bfc00584:	.word _bfc003e0
bfc00588:	.word _bfc003e0
bfc0058c:	.word _bfc003e0
bfc00590:	.word _bfc003e0
bfc00594:	.word _bfc003e0
bfc00598:	.word _bfc003e0
bfc0059c:	.word _bfc003e0
bfc005a0:	.word _bfc003e0
bfc005a4:	.word _bfc003e0
bfc005a8:	.word _bfc003e0
bfc005ac:	.word _bfc003e0
bfc005b0:	.word _bfc003e0
bfc005b4:	.word _bfc003e0
bfc005b8:	.word _bfc003e0
bfc005bc:	.word _bfc003e0
bfc005c0:	.word _bfc003e0
bfc005c4:	.word _bfc003e0
bfc005c8:	.word _bfc003e0
bfc005cc:	.word _bfc003e0
bfc005d0:	.word _bfc003e0

_bfc005d4:	mfc0	$v0,c0_sr
bfc005d8:	nop
bfc005dc:	jr	$ra
bfc005e0:	nop

_bfc005e4:	mtc0	$a0,c0_sr
bfc005e8:	nop
bfc005ec:	jr	$ra
bfc005f0:	nop

_bfc005f4:	mfc0	$v0,c0_cause
bfc005f8:	nop
bfc005fc:	jr	$ra
bfc00600:	nop

_bfc00604:	mtc0	$a0,c0_cause
bfc00608:	nop
bfc0060c:	jr	$ra
bfc00610:	nop

_bfc00614:	mfc0	$v0,c0_count
bfc00618:	nop
bfc0061c:	jr	$ra
bfc00620:	nop

_bfc00624:	mtc0	$a0,c0_count
bfc00628:	nop
bfc0062c:	jr	$ra
bfc00630:	nop

_bfc00634:	mtc0	$a0,c0_compare
bfc00638:	nop
bfc0063c:	jr	$ra
bfc00640:	nop

_bfc00644:	lui	$t0,%hi(_a0002008)
bfc00648:	addiu	$t0,$t0,%lo(_a0002008)
bfc0064c:	sd	$ra,0($t0)
bfc00650:	lui	$t0,%hi(_a0002000)
bfc00654:	addiu	$t0,$t0,%lo(_a0002000)
bfc00658:	sw	$sp,0($t0)
bfc0065c:	lui	$k0,%hi(_bfc003e0)
bfc00660:	addiu	$k0,$k0,%lo(_bfc003e0)
bfc00664:	move	$sp,$a0
bfc00668:	daddiu	$sp,$sp,-64
bfc0066c:	li	$t0,-7
bfc00670:	and	$sp,$sp,$t0
bfc00674:	move	$t0,$a0
bfc00678:	li	$a0,2
bfc0067c:	move	$a1,$zero
bfc00680:	move	$a2,$zero
bfc00684:	jalr	$t0
bfc00688:	nop
bfc0068c:	lui	$t0,%hi(_a0002000)
bfc00690:	addiu	$t0,$t0,%lo(_a0002000)
bfc00694:	lw	$sp,0($t0)
bfc00698:	lui	$t0,%hi(_a0002008)
bfc0069c:	addiu	$t0,$t0,%lo(_a0002008)
bfc006a0:	ld	$ra,0($t0)
bfc006a4:	nop
bfc006a8:	jr	$ra
bfc006ac:	nop

_bfc006b0:	lui	$sp,%hi(RESTART_SP)
bfc006b4:	ori	$sp,$sp,%lo(RESTART_SP)
bfc006b8:	lui	$ra,%hi(_bfc00000)
bfc006bc:	move	$v0,$zero
bfc006c0:	move	$v1,$zero
bfc006c4:	move	$a1,$zero
bfc006c8:	move	$a2,$zero
bfc006cc:	move	$a3,$zero
bfc006d0:	move	$t0,$zero
bfc006d4:	move	$t1,$zero
bfc006d8:	move	$t2,$zero
bfc006dc:	move	$t3,$zero
bfc006e0:	move	$t4,$zero
bfc006e4:	move	$t5,$zero
bfc006e8:	move	$t6,$zero
bfc006ec:	move	$s0,$zero
bfc006f0:	move	$s1,$zero
bfc006f4:	move	$s2,$zero
bfc006f8:	move	$s3,$zero
bfc006fc:	move	$s4,$zero
bfc00700:	move	$s5,$zero
bfc00704:	move	$s6,$zero
bfc00708:	move	$s7,$zero
bfc0070c:	move	$t8,$zero
bfc00710:	move	$t9,$zero
bfc00714:	move	$k0,$zero
bfc00718:	move	$k1,$zero
bfc0071c:	move	$gp,$zero
bfc00720:	move	$s8,$zero
bfc00724:	b	_bfc00644
bfc00728:	nop
bfc0072c:	nop

_bfc00730:	addiu	$sp,$sp,-40
bfc00734:	sd	$ra,32($sp)
bfc00738:	jal	_bfc00624
bfc0073c:	move	$a0,$zero
bfc00740:	lui	$a0,0xf
bfc00744:	jal	_bfc00634
bfc00748:	ori	$a0,$a0,0x4240
bfc0074c:	jal	_bfc005d4
bfc00750:	nop
bfc00754:	ori	$a0,$v0,0x8101
bfc00758:	ld	$ra,32($sp)
bfc0075c:	j	_bfc005e4
bfc00760:	addiu	$sp,$sp,40
bfc00764:	nop

_bfc00768:	lw	$v0,288($a0)
bfc0076c:	addiu	$sp,$sp,-56
bfc00770:	sd	$s0,40($sp)
bfc00774:	sd	$ra,48($sp)
bfc00778:	bltz	$v0,_bfc007f0
bfc0077c:	move	$s0,$a0
bfc00780:	ld	$v0,296($a0)
bfc00784:	daddiu	$v0,$v0,4
bfc00788:	sd	$v0,296($a0)

_bfc0078c:	lw	$a0,256($s0)
bfc00790:	lui	$v0,0xffff
bfc00794:	ori	$v0,$v0,0xfd
bfc00798:	and	$a0,$a0,$v0
bfc0079c:	jal	_bfc005e4
bfc007a0:	ori	$a0,$a0,0x8001
bfc007a4:	lw	$a0,36($s0)
bfc007a8:	lw	$a1,44($s0)
bfc007ac:	lw	$a2,52($s0)
bfc007b0:	lw	$a3,60($s0)
bfc007b4:	ld	$v0,296($s0)
bfc007b8:	jal	_bfc00ea0
bfc007bc:	sw	$v0,36($sp)
bfc007c0:	dsll32	$v1,$v0,0x0
bfc007c4:	dsrl32	$v1,$v1,0x0
bfc007c8:	dsrl	$v0,$v1,0x1f
bfc007cc:	beqz	$v0,_bfc007e0
bfc007d0:	sd	$v1,16($s0)
bfc007d4:	lui	$v0,0x8000
bfc007d8:	or	$v0,$v1,$v0
bfc007dc:	sd	$v0,16($s0)

_bfc007e0:	ld	$ra,48($sp)
bfc007e4:	ld	$s0,40($sp)
bfc007e8:	jr	$ra
bfc007ec:	addiu	$sp,$sp,56

_bfc007f0:	lui	$a1,%hi(_bfc02220)
bfc007f4:	addiu	$a1,$a1,%lo(_bfc02220)
bfc007f8:	jal	_bfc00bd0
bfc007fc:	li	$a0,1
bfc00800:	ld	$v1,296($s0)
bfc00804:	daddiu	$v1,$v1,8
bfc00808:	j	_bfc0078c
bfc0080c:	sd	$v1,296($s0)

_bfc00810:	lw	$v1,288($a0)
bfc00814:	lui	$v0,%hi(_bfc027d8)
bfc00818:	andi	$v1,$v1,0x7c
bfc0081c:	sll	$v1,$v1,0x1
bfc00820:	addiu	$v0,$v0,%lo(_bfc027d8)
bfc00824:	addu	$v1,$v1,$v0
bfc00828:	lw	$t9,4($v1)
bfc0082c:	addiu	$sp,$sp,-48
bfc00830:	sd	$s0,32($sp)
bfc00834:	sd	$ra,40($sp)
bfc00838:	beqz	$t9,_bfc00858
bfc0083c:	move	$s0,$a0
bfc00840:	lw	$a1,0($v1)
bfc00844:	ld	$ra,40($sp)
bfc00848:	ld	$s0,32($sp)
bfc0084c:	jr	$t9
bfc00850:	addiu	$sp,$sp,48
bfc00854:	nop

_bfc00858:	lw	$a2,0($v1)
bfc0085c:	lui	$a1,%hi(_bfc02248)
bfc00860:	addiu	$a1,$a1,%lo(_bfc02248)
bfc00864:	jal	_bfc00bd0
bfc00868:	move	$a0,$zero
bfc0086c:	lw	$v1,256($s0)
bfc00870:	andi	$v1,$v1,0x4
bfc00874:	beqzl	$v1,_bfc008b4
bfc00878:	ld	$a2,296($s0)
bfc0087c:	lui	$a1,%hi(_bfc02250)
bfc00880:	ld	$a2,304($s0)
bfc00884:	addiu	$a1,$a1,%lo(_bfc02250)
bfc00888:	jal	_bfc00bd0
bfc0088c:	move	$a0,$zero
bfc00890:	lw	$a3,256($s0)

_bfc00894:	lw	$a2,288($s0)
bfc00898:	lui	$a1,%hi(_bfc02260)
bfc0089c:	ld	$ra,40($sp)
bfc008a0:	ld	$s0,32($sp)
bfc008a4:	addiu	$a1,$a1,%lo(_bfc02260)
bfc008a8:	move	$a0,$zero
bfc008ac:	j	_bfc00bd0
bfc008b0:	addiu	$sp,$sp,48

_bfc008b4:	lui	$a1,%hi(_bfc02250)
bfc008b8:	addiu	$a1,$a1,%lo(_bfc02250)
bfc008bc:	jal	_bfc00bd0
bfc008c0:	move	$a0,$zero
bfc008c4:	j	_bfc00894
bfc008c8:	lw	$a3,256($s0)
bfc008cc:	nop

_bfc008d0:	addiu	$sp,$sp,-48
bfc008d4:	lui	$a1,%hi(_bfc02288)
bfc008d8:	sd	$s0,32($sp)
bfc008dc:	addiu	$a1,$a1,%lo(_bfc02288)
bfc008e0:	move	$s0,$a0
bfc008e4:	sd	$ra,40($sp)
bfc008e8:	jal	_bfc01240
bfc008ec:	move	$a0,$zero
bfc008f0:	lw	$v0,256($s0)
bfc008f4:	andi	$v0,$v0,0x4
bfc008f8:	beqzl	$v0,_bfc00938
bfc008fc:	ld	$a2,296($s0)
bfc00900:	ld	$a2,304($s0)
bfc00904:	lui	$a1,%hi(_bfc02250)
bfc00908:	addiu	$a1,$a1,%lo(_bfc02250)
bfc0090c:	jal	_bfc00bd0
bfc00910:	move	$a0,$zero
bfc00914:	lw	$a3,256($s0)
bfc00918:	lw	$a2,288($s0)
bfc0091c:	lui	$a1,%hi(_bfc02260)
bfc00920:	ld	$ra,40($sp)
bfc00924:	ld	$s0,32($sp)
bfc00928:	addiu	$a1,$a1,%lo(_bfc02260)
bfc0092c:	move	$a0,$zero
bfc00930:	j	_bfc00bd0
bfc00934:	addiu	$sp,$sp,48

_bfc00938:	lui	$a1,%hi(_bfc02250)
bfc0093c:	addiu	$a1,$a1,%lo(_bfc02250)
bfc00940:	jal	_bfc00bd0
bfc00944:	move	$a0,$zero
bfc00948:	lw	$a3,256($s0)
bfc0094c:	lw	$a2,288($s0)
bfc00950:	lui	$a1,%hi(_bfc02260)
bfc00954:	ld	$ra,40($sp)
bfc00958:	ld	$s0,32($sp)
bfc0095c:	addiu	$a1,$a1,%lo(_bfc02260)
bfc00960:	move	$a0,$zero
bfc00964:	j	_bfc00bd0
bfc00968:	addiu	$sp,$sp,48
bfc0096c:	nop

_bfc00970:	addiu	$sp,$sp,-64
bfc00974:	sd	$s0,32($sp)
bfc00978:	move	$s0,$a0
bfc0097c:	lw	$v0,288($s0)
bfc00980:	lw	$a0,256($a0)
bfc00984:	sd	$s2,48($sp)
bfc00988:	sd	$s1,40($sp)
bfc0098c:	andi	$s2,$a0,0xff00
bfc00990:	andi	$s1,$v0,0xff00
bfc00994:	and	$v1,$s1,$s2
bfc00998:	andi	$v0,$v1,0x100
bfc0099c:	bnez	$v0,_bfc00a60
bfc009a0:	sd	$ra,56($sp)
bfc009a4:	andi	$v0,$v1,0x200
bfc009a8:	bnez	$v0,_bfc009e8
bfc009ac:	andi	$v0,$v1,0x8000
bfc009b0:	bnez	$v0,_bfc00a80
bfc009b4:	andi	$v0,$v1,0x4000
bfc009b8:	beqz	$v0,_bfc00ac8
bfc009bc:	andi	$v0,$a0,0x4
bfc009c0:	bnezl	$v0,_bfc00a20
bfc009c4:	lui	$a1,%hi(_bfc02250)
bfc009c8:	ld	$a2,296($s0)

_bfc009cc:	lui	$a1,%hi(_bfc02250)
bfc009d0:	addiu	$a1,$a1,%lo(_bfc02250)
bfc009d4:	jal	_bfc00bd0
bfc009d8:	move	$a0,$zero
bfc009dc:	j	_bfc00a34
bfc009e0:	lw	$a3,256($s0)
bfc009e4:	nop

_bfc009e8:	jal	_bfc005f4
bfc009ec:	nop
bfc009f0:	li	$a0,-513
bfc009f4:	jal	_bfc00604
bfc009f8:	and	$a0,$v0,$a0
bfc009fc:	lui	$a1,%hi(_bfc022c0)
bfc00a00:	addiu	$a1,$a1,%lo(_bfc022c0)

_bfc00a04:	jal	_bfc00bd0
bfc00a08:	move	$a0,$zero
bfc00a0c:	lw	$v1,256($s0)
bfc00a10:	andi	$v1,$v1,0x4
bfc00a14:	beqzl	$v1,_bfc009cc
bfc00a18:	ld	$a2,296($s0)
bfc00a1c:	lui	$a1,%hi(_bfc02250)

_bfc00a20:	ld	$a2,304($s0)
bfc00a24:	addiu	$a1,$a1,%lo(_bfc02250)
bfc00a28:	jal	_bfc00bd0
bfc00a2c:	move	$a0,$zero
bfc00a30:	lw	$a3,256($s0)

_bfc00a34:	lw	$a2,288($s0)
bfc00a38:	lui	$a1,%hi(_bfc02260)
bfc00a3c:	ld	$ra,56($sp)
bfc00a40:	ld	$s2,48($sp)
bfc00a44:	ld	$s1,40($sp)
bfc00a48:	ld	$s0,32($sp)
bfc00a4c:	addiu	$a1,$a1,%lo(_bfc02260)
bfc00a50:	move	$a0,$zero
bfc00a54:	j	_bfc00bd0
bfc00a58:	addiu	$sp,$sp,64
bfc00a5c:	nop

_bfc00a60:	jal	_bfc005f4
bfc00a64:	nop
bfc00a68:	li	$a0,-257
bfc00a6c:	jal	_bfc00604
bfc00a70:	and	$a0,$v0,$a0
bfc00a74:	lui	$a1,%hi(_bfc022a0)
bfc00a78:	j	_bfc00a04
bfc00a7c:	addiu	$a1,$a1,%lo(_bfc022a0)

_bfc00a80:	jal	_bfc005f4
bfc00a84:	nop
bfc00a88:	lui	$a0,0xffff
bfc00a8c:	ori	$a0,$a0,0x7fff
bfc00a90:	jal	_bfc00604
bfc00a94:	and	$a0,$v0,$a0
bfc00a98:	jal	_bfc00614
bfc00a9c:	nop
bfc00aa0:	lui	$a0,0xf
bfc00aa4:	ori	$a0,$a0,0x4240
bfc00aa8:	ld	$ra,56($sp)
bfc00aac:	ld	$s2,48($sp)
bfc00ab0:	ld	$s1,40($sp)
bfc00ab4:	ld	$s0,32($sp)
bfc00ab8:	addu	$a0,$v0,$a0
bfc00abc:	j	_bfc00634
bfc00ac0:	addiu	$sp,$sp,64
bfc00ac4:	nop

_bfc00ac8:	lui	$a1,%hi(_bfc022e0)
bfc00acc:	addiu	$a1,$a1,%lo(_bfc022e0)
bfc00ad0:	jal	_bfc00bd0
bfc00ad4:	move	$a0,$zero
bfc00ad8:	lw	$a3,256($s0)
bfc00adc:	lw	$a2,288($s0)
bfc00ae0:	lui	$a1,%hi(_bfc022f8)
bfc00ae4:	addiu	$a1,$a1,%lo(_bfc022f8)
bfc00ae8:	jal	_bfc00bd0
bfc00aec:	move	$a0,$zero
bfc00af0:	lui	$a1,%hi(_bfc02330)
bfc00af4:	srl	$a2,$s1,0x8
bfc00af8:	srl	$a3,$s2,0x8
bfc00afc:	ld	$ra,56($sp)
bfc00b00:	ld	$s2,48($sp)
bfc00b04:	ld	$s1,40($sp)
bfc00b08:	ld	$s0,32($sp)
bfc00b0c:	addiu	$a1,$a1,%lo(_bfc02330)
bfc00b10:	move	$a0,$zero
bfc00b14:	j	_bfc00bd0
bfc00b18:	addiu	$sp,$sp,64
bfc00b1c:	nop

_bfc00b20:	lb	$a2,0($a1)
bfc00b24:	beqz	$a2,_bfc00b44
bfc00b28:	move	$v0,$a0
bfc00b2c:	move	$v1,$a0

_bfc00b30:	sb	$a2,0($v1)
bfc00b34:	addiu	$a1,$a1,1
bfc00b38:	lb	$a2,0($a1)
bfc00b3c:	bnez	$a2,_bfc00b30
bfc00b40:	addiu	$v1,$v1,1

_bfc00b44:	jr	$ra
bfc00b48:	nop
bfc00b4c:	nop
bfc00b50:	blez	$a2,_bfc00b9c
bfc00b54:	move	$v0,$a0
bfc00b58:	lbu	$v0,0($a1)
bfc00b5c:	sb	$v0,0($a0)
bfc00b60:	lb	$v1,0($a1)
bfc00b64:	bnez	$v1,_bfc00b8c
bfc00b68:	move	$a3,$zero
bfc00b6c:	jr	$ra
bfc00b70:	move	$v0,$a0
bfc00b74:	nop

_bfc00b78:	lbu	$v0,1($a1)
bfc00b7c:	sb	$v0,0($v1)
bfc00b80:	lb	$v1,1($a1)
bfc00b84:	beqz	$v1,_bfc00b98
bfc00b88:	addiu	$a1,$a1,1

_bfc00b8c:	addiu	$a3,$a3,1
bfc00b90:	bne	$a3,$a2,_bfc00b78
bfc00b94:	addu	$v1,$a0,$a3

_bfc00b98:	move	$v0,$a0
_bfc00b9c:	jr	$ra
bfc00ba0:	nop
bfc00ba4:	nop
bfc00ba8:	lb	$v0,0($a0)
bfc00bac:	beqz	$v0,_bfc00bc8
bfc00bb0:	move	$a1,$zero
bfc00bb4:	addiu	$a1,$a1,1

_bfc00bb8:	addu	$v0,$a0,$a1
bfc00bbc:	lb	$v1,0($v0)
bfc00bc0:	bnezl	$v1,_bfc00bb8
bfc00bc4:	addiu	$a1,$a1,1

_bfc00bc8:	jr	$ra
bfc00bcc:	move	$v0,$a1

_bfc00bd0:	addiu	$sp,$sp,-80
bfc00bd4:	sd	$s2,56($sp)
bfc00bd8:	sd	$s0,40($sp)
bfc00bdc:	sd	$ra,72($sp)
bfc00be0:	sd	$s3,64($sp)
bfc00be4:	sd	$s1,48($sp)
bfc00be8:	move	$s0,$a1
bfc00bec:	lb	$a1,0($a1)
bfc00bf0:	addiu	$v0,$sp,96
bfc00bf4:	sd	$a2,96($sp)
bfc00bf8:	sd	$a3,104($sp)
bfc00bfc:	sw	$v0,32($sp)
bfc00c00:	beqz	$a1,_bfc00c8c
bfc00c04:	move	$s2,$a0
bfc00c08:	lui	$v0,%hi(_bfc02630)
bfc00c0c:	j	_bfc00c30
bfc00c10:	addiu	$s3,$v0,%lo(_bfc02630)
bfc00c14:	nop

_bfc00c18:	jal	_bfc01218
bfc00c1c:	move	$a0,$s2
bfc00c20:	addiu	$s0,$s0,1

_bfc00c24:	lb	$a1,0($s0)
bfc00c28:	beqz	$a1,_bfc00c90
bfc00c2c:	ld	$ra,72($sp)

_bfc00c30:	li	$v0,37

_bfc00c34:	bnel	$a1,$v0,_bfc00c18
bfc00c38:	andi	$a1,$a1,0xff
bfc00c3c:	addiu	$s0,$s0,1
bfc00c40:	lb	$v1,0($s0)
bfc00c44:	li	$v0,115
bfc00c48:	beq	$v1,$v0,_bfc00dd0
bfc00c4c:	slti	$v0,$v1,116
bfc00c50:	beqz	$v0,_bfc00cb0
bfc00c54:	li	$v0,120
bfc00c58:	beq	$v1,$a1,_bfc00dbc
bfc00c5c:	li	$v0,99
bfc00c60:	bne	$v1,$v0,_bfc00c24
bfc00c64:	addiu	$s0,$s0,1
bfc00c68:	lw	$v0,32($sp)
bfc00c6c:	move	$a0,$s2
bfc00c70:	lbu	$a1,7($v0)
bfc00c74:	addiu	$v0,$v0,8
bfc00c78:	jal	_bfc01218
bfc00c7c:	sw	$v0,32($sp)
bfc00c80:	lb	$a1,0($s0)
bfc00c84:	bnez	$a1,_bfc00c34
bfc00c88:	li	$v0,37

_bfc00c8c:	ld	$ra,72($sp)

_bfc00c90:	ld	$s3,64($sp)
bfc00c94:	ld	$s2,56($sp)
bfc00c98:	ld	$s1,48($sp)
bfc00c9c:	ld	$s0,40($sp)
bfc00ca0:	move	$v0,$zero
bfc00ca4:	jr	$ra
bfc00ca8:	addiu	$sp,$sp,80
bfc00cac:	nop

_bfc00cb0:	bnel	$v1,$v0,_bfc00c24
bfc00cb4:	addiu	$s0,$s0,1
bfc00cb8:	lw	$v0,32($sp)
bfc00cbc:	lw	$s1,4($v0)
bfc00cc0:	addiu	$v0,$v0,8
bfc00cc4:	srl	$a0,$s1,0x1c
bfc00cc8:	sltiu	$v1,$a0,10
bfc00ccc:	sw	$v0,32($sp)
bfc00cd0:	bnez	$v1,_bfc00cdc
bfc00cd4:	addiu	$a1,$a0,48
bfc00cd8:	addiu	$a1,$a0,87

_bfc00cdc:	jal	_bfc01218
bfc00ce0:	move	$a0,$s2
bfc00ce4:	sra	$v0,$s1,0x18
bfc00ce8:	andi	$v0,$v0,0xf
bfc00cec:	sltiu	$v1,$v0,10
bfc00cf0:	bnez	$v1,_bfc00cfc
bfc00cf4:	addiu	$a1,$v0,48
bfc00cf8:	addiu	$a1,$v0,87

_bfc00cfc:	jal	_bfc01218
bfc00d00:	move	$a0,$s2
bfc00d04:	sra	$v0,$s1,0x14
bfc00d08:	andi	$v0,$v0,0xf
bfc00d0c:	sltiu	$v1,$v0,10
bfc00d10:	bnez	$v1,_bfc00d1c
bfc00d14:	addiu	$a1,$v0,48
bfc00d18:	addiu	$a1,$v0,87

_bfc00d1c:	jal	_bfc01218
bfc00d20:	move	$a0,$s2
bfc00d24:	sra	$v0,$s1,0x10
bfc00d28:	andi	$v0,$v0,0xf
bfc00d2c:	sltiu	$v1,$v0,10
bfc00d30:	bnez	$v1,_bfc00d3c
bfc00d34:	addiu	$a1,$v0,48
bfc00d38:	addiu	$a1,$v0,87

_bfc00d3c:	jal	_bfc01218
bfc00d40:	move	$a0,$s2
bfc00d44:	sra	$v0,$s1,0xc
bfc00d48:	andi	$v0,$v0,0xf
bfc00d4c:	sltiu	$v1,$v0,10
bfc00d50:	bnez	$v1,_bfc00d5c
bfc00d54:	addiu	$a1,$v0,48
bfc00d58:	addiu	$a1,$v0,87

_bfc00d5c:	jal	_bfc01218
bfc00d60:	move	$a0,$s2
bfc00d64:	sra	$v0,$s1,0x8
bfc00d68:	andi	$v0,$v0,0xf
bfc00d6c:	sltiu	$v1,$v0,10
bfc00d70:	bnez	$v1,_bfc00d7c
bfc00d74:	addiu	$a1,$v0,48
bfc00d78:	addiu	$a1,$v0,87

_bfc00d7c:	jal	_bfc01218
bfc00d80:	move	$a0,$s2
bfc00d84:	sra	$v0,$s1,0x4
bfc00d88:	andi	$v0,$v0,0xf
bfc00d8c:	sltiu	$v1,$v0,10
bfc00d90:	bnez	$v1,_bfc00d9c
bfc00d94:	addiu	$a1,$v0,48
bfc00d98:	addiu	$a1,$v0,87

_bfc00d9c:	jal	_bfc01218
bfc00da0:	move	$a0,$s2
bfc00da4:	andi	$v1,$s1,0xf
bfc00da8:	sltiu	$v0,$v1,10
bfc00dac:	beqz	$v0,_bfc00c18
bfc00db0:	addiu	$a1,$v1,87
bfc00db4:	j	_bfc00c18
bfc00db8:	addiu	$a1,$v1,48

_bfc00dbc:	move	$a0,$s2
bfc00dc0:	jal	_bfc01218
bfc00dc4:	li	$a1,37
bfc00dc8:	j	_bfc00c24
bfc00dcc:	addiu	$s0,$s0,1

_bfc00dd0:	lw	$v0,32($sp)
bfc00dd4:	lw	$a1,4($v0)
bfc00dd8:	beqzl	$a1,_bfc00de0
bfc00ddc:	move	$a1,$s3

_bfc00de0:	addiu	$v0,$v0,8
bfc00de4:	move	$a0,$s2
bfc00de8:	jal	_bfc01240
bfc00dec:	sw	$v0,32($sp)
bfc00df0:	j	_bfc00c24
bfc00df4:	addiu	$s0,$s0,1
bfc00df8:	j	_bfc00e0c
bfc00dfc:	lb	$v1,0($a0)

_bfc00e00:	sw	$v1,84($v0)
bfc00e04:	addiu	$a0,$a0,1
bfc00e08:	lb	$v1,0($a0)

_bfc00e0c:	bnez	$v1,_bfc00e00
bfc00e10:	lui	$v0,%hi(REMOTE_CTRL)
bfc00e14:	li	$v1,2
bfc00e18:	sw	$v1,%lo(REMOTE_CTRL_rommon_variable_command)($v0)
bfc00e1c:	lw	$a0,%lo(REMOTE_CTRL_rommon_variable_command)($v0)
bfc00e20:	bnez	$a0,_bfc00e68
bfc00e24:	li	$v0,-1
bfc00e28:	addiu	$a2,$a2,-1
bfc00e2c:	lui	$a3,%hi(REMOTE_CTRL)

_bfc00e30:	lw	$v0,%lo(REMOTE_CTRL_rommon_variable)($a3)
bfc00e34:	addiu	$a0,$a0,1
bfc00e38:	sll	$v0,$v0,0x18
bfc00e3c:	sra	$v0,$v0,0x18
bfc00e40:	sb	$v0,0($a1)
bfc00e44:	addiu	$a1,$a1,1
bfc00e48:	slt	$v1,$a0,$a2
bfc00e4c:	beqz	$v0,_bfc00e5c
bfc00e50:	sb	$zero,0($a1)
bfc00e54:	bnez	$v1,_bfc00e30
bfc00e58:	nop

_bfc00e5c:	li	$v0,3
bfc00e60:	sw	$v0,%lo(REMOTE_CTRL_rommon_variable_command)($a3)
bfc00e64:	move	$v0,$zero

_bfc00e68:	jr	$ra
bfc00e6c:	nop
bfc00e70:	j	_bfc00e84
bfc00e74:	lb	$v1,0($a0)

_bfc00e78:	sw	$v1,%lo(REMOTE_CTRL_rommon_variable)($v0)
bfc00e7c:	addiu	$a0,$a0,1
bfc00e80:	lb	$v1,0($a0)

_bfc00e84:	bnez	$v1,_bfc00e78
bfc00e88:	lui	$v0,%hi(REMOTE_CTRL)
bfc00e8c:	li	$v1,1
bfc00e90:	sw	$v1,%lo(REMOTE_CTRL_rommon_variable_command)($v0)
bfc00e94:	jr	$ra
bfc00e98:	li	$v0,2048
bfc00e9c:	nop

_bfc00ea0:	addiu	$sp,$sp,-88
bfc00ea4:	sltiu	$v0,$a0,133
bfc00ea8:	sd	$s2,72($sp)
bfc00eac:	sd	$s1,64($sp)
bfc00eb0:	sd	$ra,80($sp)
bfc00eb4:	sd	$s0,56($sp)
bfc00eb8:	move	$t0,$a0
bfc00ebc:	move	$t1,$a1
bfc00ec0:	move	$s1,$a2
bfc00ec4:	bnez	$v0,_bfc00ef8
bfc00ec8:	move	$s2,$a3

_bfc00ecc:	lui	$a1,%hi(_bfc026b0)
bfc00ed0:	lw	$a3,124($sp)
bfc00ed4:	addiu	$a1,$a1,%lo(_bfc026b0)
bfc00ed8:	move	$a2,$t0
bfc00edc:	li	$a0,1
bfc00ee0:	sw	$t1,36($sp)
bfc00ee4:	sw	$s1,44($sp)
bfc00ee8:	jal	_bfc00bd0
bfc00eec:	sw	$s2,52($sp)

_bfc00ef0:	j	_bfc00f20
bfc00ef4:	li	$a1,-1

_bfc00ef8:	lui	$v1,%hi(_bfc02000)
bfc00efc:	sll	$v0,$a0,0x2
bfc00f00:	addiu	$v1,$v1,%lo(_bfc02000)
bfc00f04:	addu	$v0,$v0,$v1
bfc00f08:	lw	$a0,0($v0)
bfc00f0c:	jr	$a0
bfc00f10:	nop

_bfc00f14:	lui	$v0,%hi(REMOTE_CTRL)
bfc00f18:	lw	$v1,%lo(REMOTE_CTRL_ram_size)($v0)
bfc00f1c:	sll	$a1,$v1,0x14

_bfc00f20:	ld	$ra,80($sp)

_bfc00f24:	ld	$s2,72($sp)
bfc00f28:	ld	$s1,64($sp)
bfc00f2c:	ld	$s0,56($sp)
bfc00f30:	move	$v0,$a1
bfc00f34:	jr	$ra
bfc00f38:	addiu	$sp,$sp,88

_bfc00f3c:	lui	$v0,%hi(REMOTE_CTRL)
bfc00f40:	sw	$zero,%lo(REMOTE_CTRL_cookie_position)($v0)
bfc00f44:	lw	$v1,%lo(REMOTE_CTRL_cookie_data)($v0)
bfc00f48:	addiu	$a0,$a1,2
bfc00f4c:	sh	$v1,0($a1)
bfc00f50:	li	$a1,1
bfc00f54:	nop

_bfc00f58:	lui	$v0,%hi(REMOTE_CTRL)
bfc00f5c:	sw	$a1,%lo(REMOTE_CTRL_cookie_position)($v0)
bfc00f60:	lw	$v1,%lo(REMOTE_CTRL_cookie_data)($v0)
bfc00f64:	addiu	$a1,$a1,1
bfc00f68:	li	$v0,64
bfc00f6c:	sh	$v1,0($a0)
bfc00f70:	bne	$a1,$v0,_bfc00f58
bfc00f74:	addiu	$a0,$a0,2

_bfc00f78:	move	$a1,$zero
bfc00f7c:	ld	$ra,80($sp)
bfc00f80:	ld	$s2,72($sp)
bfc00f84:	ld	$s1,64($sp)
bfc00f88:	ld	$s0,56($sp)
bfc00f8c:	move	$v0,$a1
bfc00f90:	jr	$ra
bfc00f94:	addiu	$sp,$sp,88

_bfc00f98:	lui	$a1,%hi(_bfc02638)
bfc00f9c:	addiu	$a1,$a1,%lo(_bfc02638)
bfc00fa0:	move	$a0,$zero
bfc00fa4:	jal	_bfc00bd0
bfc00fa8:	lui	$s0,%hi(REMOTE_CTRL)
bfc00fac:	lw	$v1,%lo(REMOTE_CTRL_restart_ios)($s0)
bfc00fb0:	beqz	$v1,_bfc01208
bfc00fb4:	li	$v0,1
bfc00fb8:	lui	$a1,%hi(_bfc02658)
bfc00fbc:	addiu	$a1,$a1,%lo(_bfc02658)
bfc00fc0:	jal	_bfc00bd0
bfc00fc4:	move	$a0,$zero
bfc00fc8:	jal	_bfc006b0
bfc00fcc:	lw	$a0,40($s0)
bfc00fd0:	j	_bfc00f20
bfc00fd4:	move	$a1,$zero

_bfc00fd8:	lui	$v0,%hi(_a0002010)
bfc00fdc:	jal	_bfc00b20
bfc00fe0:	lw	$a0,%lo(_a0002010)($v0)
bfc00fe4:	j	_bfc00f20
bfc00fe8:	li	$a1,1

_bfc00fec:	lui	$v0,%hi(_a0002014)
bfc00ff0:	j	_bfc00f20
bfc00ff4:	lw	$a1,%lo(_a0002014)($v0)

_bfc00ff8:	lui	$v1,%hi(REMOTE_CTRL)
bfc00ffc:	lw	$a0,%lo(REMOTE_CTRL_io_memory_size)($v1)
bfc01000:	andi	$v0,$a0,0x8000
bfc01004:	bnez	$v0,_bfc0101c
bfc01008:	lui	$v0,0xffff
bfc0100c:	lw	$v0,%lo(REMOTE_CTRL_nvram_address)($v1)
bfc01010:	lw	$a1,2016($v0)
bfc01014:	bnez	$a1,_bfc00f20
bfc01018:	lui	$v0,0xffff

_bfc0101c:	ori	$v0,$v0,0x7fff
bfc01020:	j	_bfc00f20
bfc01024:	and	$a1,$a0,$v0

_bfc01028:	lui	$v0,%hi(REMOTE_CTRL)
bfc0102c:	lw	$v1,%lo(REMOTE_CTRL_nvram_address)($v0)
bfc01030:	j	_bfc00f20
bfc01034:	addiu	$a1,$v1,1024

_bfc01038:	lui	$v0,%hi(REMOTE_CTRL)
bfc0103c:	lw	$v1,%lo(REMOTE_CTRL_nvram_address)($v0)
bfc01040:	li	$a1,1
bfc01044:	j	_bfc00f20
bfc01048:	sw	$t1,2016($v1)

_bfc0104c:	j	_bfc00f20
bfc01050:	li	$a1,896

_bfc01054:	j	_bfc00f20
bfc01058:	li	$a1,2048

_bfc0105c:	move	$s0,$a1
bfc01060:	lui	$a1,%hi(_bfc02670)
bfc01064:	addiu	$a1,$a1,%lo(_bfc02670)
bfc01068:	li	$a0,1
bfc0106c:	jal	_bfc00bd0
bfc01070:	move	$a2,$t1
bfc01074:	lb	$v1,0($s0)
bfc01078:	beqz	$v1,_bfc01094
bfc0107c:	lui	$v0,%hi(REMOTE_CTRL)

_bfc01080:	sw	$v1,%lo(REMOTE_CTRL_rommon_variable)($v0)
bfc01084:	addiu	$s0,$s0,1
bfc01088:	lb	$v1,0($s0)
bfc0108c:	bnez	$v1,_bfc01080
bfc01090:	lui	$v0,%hi(REMOTE_CTRL)

_bfc01094:	li	$v1,2
bfc01098:	sw	$v1,%lo(REMOTE_CTRL_rommon_variable_command)($v0)
bfc0109c:	lw	$a0,%lo(REMOTE_CTRL_rommon_variable_command)($v0)
bfc010a0:	bnez	$a0,_bfc00f20
bfc010a4:	li	$a1,-1
bfc010a8:	move	$a2,$s1
bfc010ac:	addiu	$a3,$s2,-1
bfc010b0:	move	$v1,$zero
bfc010b4:	lui	$a0,%hi(REMOTE_CTRL)

_bfc010b8:	lw	$v0,%lo(REMOTE_CTRL_rommon_variable)($a0)
bfc010bc:	sll	$v0,$v0,0x18
bfc010c0:	sra	$v0,$v0,0x18
bfc010c4:	sb	$v0,0($a2)
bfc010c8:	addiu	$a2,$a2,1
bfc010cc:	beqz	$v0,_bfc010e4
bfc010d0:	sb	$zero,0($a2)
bfc010d4:	addiu	$v1,$v1,1
bfc010d8:	slt	$v0,$v1,$a3
bfc010dc:	bnez	$v0,_bfc010b8
bfc010e0:	nop

_bfc010e4:	li	$v0,3
bfc010e8:	move	$a1,$zero
bfc010ec:	sw	$v0,88($a0)
bfc010f0:	j	_bfc00f24
bfc010f4:	ld	$ra,80($sp)

_bfc010f8:	li	$v1,1
bfc010fc:	lui	$v0,%hi(REMOTE_CTRL)
bfc01100:	move	$a1,$zero
bfc01104:	j	_bfc00f20
bfc01108:	sw	$v1,%lo(REMOTE_CTRL_stop_virtual_machine)($v0)

_bfc0110c:	lui	$v0,%hi(REMOTE_CTRL)
bfc01110:	lw	$v1,%lo(REMOTE_CTRL_config_reg)($v0)
bfc01114:	j	_bfc00f20
bfc01118:	nor	$a1,$zero,$v1

_bfc0111c:	j	_bfc00f20
bfc01120:	li	$a1,3072

_bfc01124:	andi	$a1,$a1,0xff
bfc01128:	jal	_bfc01218
bfc0112c:	move	$a0,$zero
bfc01130:	j	_bfc00f20
bfc01134:	move	$a1,$zero

_bfc01138:	lui	$v0,%hi(REMOTE_CTRL)
bfc0113c:	j	_bfc00f20
bfc01140:	lw	$a1,%lo(REMOTE_CTRL_config_reg)($v0)

_bfc01144:	lui	$v0,%hi(REMOTE_CTRL)
bfc01148:	lw	$v1,%lo(REMOTE_CTRL_iomem_size)($v0)
bfc0114c:	j	_bfc00f20
bfc01150:	sll	$a1,$v1,0x14

_bfc01154:	lui	$v0,%hi(REMOTE_CTRL)
bfc01158:	lw	$v1,%lo(REMOTE_CTRL_nvram_size)($v0)
bfc0115c:	j	_bfc00f20
bfc01160:	sll	$a1,$v1,0xa

_bfc01164:	lui	$v0,%hi(_a0002018)
bfc01168:	j	_bfc00f20
bfc0116c:	lw	$a1,%lo(_a0002018)($v0)

_bfc01170:	lui	$v0,%hi(_bfc028d8)
bfc01174:	j	_bfc00f20
bfc01178:	lw	$a1,%lo(_bfc028d8)($v0)

_bfc0117c:	lui	$v0,%hi(_a0002010)
bfc01180:	j	_bfc00f20
bfc01184:	lw	$a1,%lo(_a0002010)($v0)

_bfc01188:	move	$s0,$a1
bfc0118c:	lui	$a1,%hi(_bfc02690)
bfc01190:	addiu	$a1,$a1,%lo(_bfc02690)
bfc01194:	li	$a0,1
bfc01198:	jal	_bfc00bd0
bfc0119c:	move	$a2,$t1
bfc011a0:	lb	$v1,0($s0)
bfc011a4:	beqzl	$v1,_bfc011c8
bfc011a8:	li	$v1,1
bfc011ac:	lui	$v0,%hi(REMOTE_CTRL)

_bfc011b0:	sw	$v1,%lo(REMOTE_CTRL_rommon_variable)($v0)
bfc011b4:	addiu	$s0,$s0,1
bfc011b8:	lb	$v1,0($s0)
bfc011bc:	bnez	$v1,_bfc011b0
bfc011c0:	lui	$v0,%hi(REMOTE_CTRL)
bfc011c4:	li	$v1,1

_bfc011c8:	lui	$v0,%hi(REMOTE_CTRL)
bfc011cc:	li	$a1,2048
bfc011d0:	sw	$v1,%lo(REMOTE_CTRL_rommon_variable_command)($v0)
bfc011d4:	j	_bfc00f24
bfc011d8:	ld	$ra,80($sp)

_bfc011dc:	lui	$v0,%hi(REMOTE_CTRL)
bfc011e0:	j	_bfc00f20
bfc011e4:	lw	$a1,%lo(REMOTE_CTRL_elf_machine_id)($v0)

_bfc011e8:	lui	$v0,%hi(_bfc00548)
bfc011ec:	j	_bfc00f20
bfc011f0:	addiu	$a1,$v0,%lo(_bfc00548)

_bfc011f4:	lui	$v0,%hi(_a0002014)
bfc011f8:	jal	_bfc00b20
bfc011fc:	lw	$a0,%lo(_a0002014)($v0)
bfc01200:	j	_bfc00f20
bfc01204:	li	$a1,1

_bfc01208:	jalr	$v1
bfc0120c:	sw	$v0,52($s0)
bfc01210:	j	_bfc00f20
bfc01214:	move	$a1,$zero

_bfc01218:	bnez	$a0,_bfc01230
bfc0121c:	andi	$a1,$a1,0xff
bfc01220:	lui	$v0,%hi(REMOTE_CTRL)
bfc01224:	jr	$ra
bfc01228:	sw	$a1,%lo(REMOTE_CTRL_console_output)($v0)
bfc0122c:	nop

_bfc01230:	lui	$v0,%hi(REMOTE_CTRL)
bfc01234:	jr	$ra
bfc01238:	sw	$a1,%lo(REMOTE_CTRL_log_output)($v0)
bfc0123c:	nop

_bfc01240:	lbu	$v1,0($a1)
bfc01244:	beqz	$v1,_bfc01268
bfc01248:	nop
bfc0124c:	beqz	$a0,_bfc01270
bfc01250:	lui	$v0,%hi(REMOTE_CTRL)
bfc01254:	sw	$v1,%lo(REMOTE_CTRL_log_output)($v0)

_bfc01258:	addiu	$a1,$a1,1
bfc0125c:	lbu	$v1,0($a1)
bfc01260:	bnezl	$v1,_bfc01258
bfc01264:	sw	$v1,%lo(REMOTE_CTRL_log_output)($v0)

_bfc01268:	jr	$ra
bfc0126c:	nop

_bfc01270:	sw	$v1,%lo(REMOTE_CTRL_console_output)($v0)
bfc01274:	addiu	$a1,$a1,1
bfc01278:	lbu	$v1,0($a1)
bfc0127c:	bnez	$v1,_bfc01270
bfc01280:	lui	$v0,%hi(REMOTE_CTRL)
bfc01284:	j	_bfc01268
bfc01288:	nop
bfc0128c:	nop
bfc01290:	move	$t9,$zero
bfc01294:	jr	$t9
bfc01298:	nop
bfc0129c:	nop

start_microcode:
_bfc012a0:	lui	$a1,%hi(_bfc02710)
bfc012a4:	addiu	$sp,$sp,-56
bfc012a8:	addiu	$a1,$a1,%lo(_bfc02710)
bfc012ac:	move	$a0,$zero
bfc012b0:	sd	$ra,48($sp)
bfc012b4:	sd	$s0,32($sp)
bfc012b8:	jal	_bfc00bd0
bfc012bc:	sd	$s1,40($sp)
bfc012c0:	lui	$a1,%hi(_bfc02730)
bfc012c4:	addiu	$a1,$a1,%lo(_bfc02730)
bfc012c8:	li	$a0,1
bfc012cc:	jal	_bfc00bd0
bfc012d0:	lui	$s0,%hi(REMOTE_CTRL)
bfc012d4:	lui	$v0,0x1e94
bfc012d8:	lw	$v1,%lo(REMOTE_CTRL_rom_id)($s0)
bfc012dc:	ori	$v0,$v0,0xb3df
bfc012e0:	beql	$v1,$v0,_bfc01308
bfc012e4:	lw	$s0,%lo(REMOTE_CTRL_nvram_address)($s0)
bfc012e8:	lui	$a1,%hi(_bfc02748)
bfc012ec:	addiu	$a1,$a1,%lo(_bfc02748)
bfc012f0:	jal	_bfc00bd0
bfc012f4:	move	$a0,$zero
bfc012f8:	move	$v1,$zero
bfc012fc:	jalr	$v1
bfc01300:	nop
bfc01304:	lw	$s0,68($s0)

_bfc01308:	lui	$a1,%hi(_bfc02790)
bfc0130c:	addiu	$v1,$s0,128
bfc01310:	move	$a0,$v1
bfc01314:	addiu	$a1,$a1,%lo(_bfc02790)
bfc01318:	lui	$v0,%hi(_a0002014)
bfc0131c:	jal	_bfc00b20
bfc01320:	sw	$v1,%lo(_a0002014)($v0)
bfc01324:	addiu	$v1,$s0,512
bfc01328:	lui	$a1,%hi(_bfc02798)
bfc0132c:	move	$a0,$v1
bfc01330:	addiu	$a1,$a1,%lo(_bfc02798)
bfc01334:	lui	$v0,%hi(_a0002010)
bfc01338:	sw	$v1,%lo(_a0002010)($v0)
bfc0133c:	jal	_bfc00b20
bfc01340:	addiu	$s0,$s0,1920
bfc01344:	lui	$v0,%hi(_a0002018)
bfc01348:	sw	$s0,%lo(_a0002018)($v0)
bfc0134c:	jal	_bfc00730
bfc01350:	lui	$s1,%hi(_bfc027a0)
bfc01354:	lui	$s0,%hi(REMOTE_CTRL)

_bfc01358:	lw	$a2,%lo(REMOTE_CTRL_elf_entry_point)($s0)
bfc0135c:	move	$a0,$zero
bfc01360:	jal	_bfc00bd0
bfc01364:	addiu	$a1,$s1,%lo(_bfc027a0)
bfc01368:	jal	_bfc00644
bfc0136c:	lw	$a0,%lo(REMOTE_CTRL_elf_entry_point)($s0)
bfc01370:	lw	$v0,%lo(REMOTE_CTRL_restart_ios)($s0)
bfc01374:	bnezl	$v0,_bfc01358
bfc01378:	lui	$s0,%hi(REMOTE_CTRL)
bfc0137c:	lui	$a1,%hi(_bfc027c0)
bfc01380:	addiu	$a1,$a1,%lo(_bfc027c0)
bfc01384:	jal	_bfc00bd0
bfc01388:	move	$a0,$zero
bfc0138c:	li	$v1,1
bfc01390:	sw	$v1,%lo(REMOTE_CTRL_stop_virtual_machine)($s0)
bfc01394:	ld	$ra,48($sp)
bfc01398:	ld	$s1,40($sp)
bfc0139c:	ld	$s0,32($sp)
bfc013a0:	jr	$ra
bfc013a4:	addiu	$sp,$sp,56
	.org 0x2000, 0


	###################################################
	.section .rodata
	.align 2
_bfc02000:	.word _bfc00ecc
bfc02004:	.word _bfc01124
bfc02008:	.word _bfc0111c
bfc0200c:	.word _bfc00ecc
bfc02010:	.word _bfc00f14
bfc02014:	.word _bfc00ecc
bfc02018:	.word _bfc0110c
bfc0201c:	.word _bfc011dc
bfc02020:	.word _bfc00f98
bfc02024:	.word _bfc00ecc
bfc02028:	.word _bfc01170
bfc0202c:	.word _bfc00ecc
bfc02030:	.word _bfc00ecc
bfc02034:	.word _bfc01164
bfc02038:	.word _bfc00ecc
bfc0203c:	.word _bfc00ecc
bfc02040:	.word _bfc00ecc
bfc02044:	.word _bfc00ecc
bfc02048:	.word _bfc00ecc
bfc0204c:	.word _bfc00ecc
bfc02050:	.word _bfc00ecc
bfc02054:	.word _bfc00ecc
bfc02058:	.word _bfc00ecc
bfc0205c:	.word _bfc00ecc
bfc02060:	.word _bfc01154
bfc02064:	.word _bfc00ecc
bfc02068:	.word _bfc00ecc
bfc0206c:	.word _bfc01144
bfc02070:	.word _bfc01138
bfc02074:	.word _bfc00ecc
bfc02078:	.word _bfc00ecc
bfc0207c:	.word _bfc00ecc
bfc02080:	.word _bfc00ecc
bfc02084:	.word _bfc00ecc
bfc02088:	.word _bfc00fec
bfc0208c:	.word _bfc00fd8
bfc02090:	.word _bfc0117c
bfc02094:	.word _bfc011f4
bfc02098:	.word _bfc00ecc
bfc0209c:	.word _bfc00ecc
bfc020a0:	.word _bfc00ecc
bfc020a4:	.word _bfc00ecc
bfc020a8:	.word _bfc011e8
bfc020ac:	.word _bfc010f8
bfc020b0:	.word _bfc00f3c
bfc020b4:	.word _bfc01188
bfc020b8:	.word _bfc0105c
bfc020bc:	.word _bfc01054
bfc020c0:	.word _bfc00f78
bfc020c4:	.word _bfc00f78
bfc020c8:	.word _bfc00ecc
bfc020cc:	.word _bfc00ecc
bfc020d0:	.word _bfc00ecc
bfc020d4:	.word _bfc00ecc
bfc020d8:	.word _bfc01028
bfc020dc:	.word _bfc0104c
bfc020e0:	.word _bfc00ecc
bfc020e4:	.word _bfc00ecc
bfc020e8:	.word _bfc00ef0
bfc020ec:	.word _bfc01038
bfc020f0:	.word _bfc00ff8
bfc020f4:	.word _bfc00ecc
bfc020f8:	.word _bfc00ecc
bfc020fc:	.word _bfc00ecc
bfc02100:	.word _bfc00ecc
bfc02104:	.word _bfc00ecc
bfc02108:	.word _bfc00ecc
bfc0210c:	.word _bfc00ecc
bfc02110:	.word _bfc00ecc
bfc02114:	.word _bfc00ecc
bfc02118:	.word _bfc00ecc
bfc0211c:	.word _bfc00ecc
bfc02120:	.word _bfc00ecc
bfc02124:	.word _bfc00ecc
bfc02128:	.word _bfc00ef0
bfc0212c:	.word _bfc00ecc
bfc02130:	.word _bfc00ecc
bfc02134:	.word _bfc00ecc
bfc02138:	.word _bfc00ecc
bfc0213c:	.word _bfc00ecc
bfc02140:	.word _bfc00ecc
bfc02144:	.word _bfc00ecc
bfc02148:	.word _bfc00ecc
bfc0214c:	.word _bfc00ecc
bfc02150:	.word _bfc00ecc
bfc02154:	.word _bfc00ecc
bfc02158:	.word _bfc00ecc
bfc0215c:	.word _bfc00ecc
bfc02160:	.word _bfc00ecc
bfc02164:	.word _bfc00ecc
bfc02168:	.word _bfc00ecc
bfc0216c:	.word _bfc00ecc
bfc02170:	.word _bfc00ecc
bfc02174:	.word _bfc00ecc
bfc02178:	.word _bfc00ecc
bfc0217c:	.word _bfc00ecc
bfc02180:	.word _bfc00ecc
bfc02184:	.word _bfc00ecc
bfc02188:	.word _bfc00ecc
bfc0218c:	.word _bfc00ecc
bfc02190:	.word _bfc00ecc
bfc02194:	.word _bfc00ecc
bfc02198:	.word _bfc00ecc
bfc0219c:	.word _bfc00ecc
bfc021a0:	.word _bfc00ecc
bfc021a4:	.word _bfc00ecc
bfc021a8:	.word _bfc00ecc
bfc021ac:	.word _bfc00ecc
bfc021b0:	.word _bfc00ecc
bfc021b4:	.word _bfc00ecc
bfc021b8:	.word _bfc00ecc
bfc021bc:	.word _bfc00ecc
bfc021c0:	.word _bfc00ecc
bfc021c4:	.word _bfc00ecc
bfc021c8:	.word _bfc00ecc
bfc021cc:	.word _bfc00ecc
bfc021d0:	.word _bfc00ecc
bfc021d4:	.word _bfc00ecc
bfc021d8:	.word _bfc00ecc
bfc021dc:	.word _bfc00ecc
bfc021e0:	.word _bfc00ecc
bfc021e4:	.word _bfc00ecc
bfc021e8:	.word _bfc00ecc
bfc021ec:	.word _bfc00ecc
bfc021f0:	.word _bfc00ecc
bfc021f4:	.word _bfc00ecc
bfc021f8:	.word _bfc00ecc
bfc021fc:	.word _bfc00ecc
bfc02200:	.word _bfc00ecc
bfc02204:	.word _bfc00ecc
bfc02208:	.word _bfc00ecc
bfc0220c:	.word _bfc00ecc
bfc02210:	.word _bfc00f14
bfc02214:	.word 0
bfc02218:	.word 0
bfc0221c:	.word 0
	.align 2

	#############################################################
	.section .rodata.str1.8
	.align 3
_bfc02220:	.string "Warning: System Call in BD Slot.\n"
	.align 3
_bfc02248:	.string "\n%s\n"
	.align 3
_bfc02250:	.string "PC = 0x%x, "
	.align 3
_bfc02260:	.string "Cause = 0x%x, Status Reg = 0x%x\n"
	.align 3
_bfc02288:	.string "Cache Exception:\n"
	.align 3
_bfc022a0:	.string "\n*** Software Interrupt 0 ***\n"
	.align 3
_bfc022c0:	.string "\n*** Software Interrupt 1 ***\n"
	.align 3
_bfc022e0:	.string "\n*** Unknown IRQ ***\n"
	.align 3
_bfc022f8:	.string "Stacked Cause Reg = 0x%x, Stacked Status Reg = 0x%x\n"
	.align 3
_bfc02330:	.string "Current Int Cause = 0x%x, Current Int Status = 0x%x\n"
	.align 3
_bfc02368:	.string "*** CPU Interrupt ***"
	.align 3
_bfc02380:	.string "*** TLB Modification Exception ***"
	.align 3
_bfc023a8:	.string "*** TLB (Load/Fetch) Exception ***"
	.align 3
_bfc023d0:	.string "*** TLB (Store) Exception ***"
	.align 3
_bfc023f0:	.string "*** Address Error (Load/Fetch) Exception ***"
	.align 3
_bfc02420:	.string "*** Address Error (Store) Exception ***"
	.align 3
_bfc02448:	.string "*** Bus Error (Fetch) Exception ***"
	.align 3
_bfc02470:	.string "*** Bus Error (Load) Exception ***"
	.align 3
_bfc02498:	.string "*** System Call Exception ***"
	.align 3
_bfc024b8:	.string "*** Break Point Exception ***"
	.align 3
_bfc024d8:	.string "*** Illegal Opcode Exception ***"
	.align 3
_bfc02500:	.string "*** Coprocessor Unusable Exception ***"
	.align 3
_bfc02528:	.string "*** Arithmetic Overflow Exception ***"
	.align 3
_bfc02550:	.string "*** Trap Exception ***"
	.align 3
_bfc02568:	.string "*** Virtual Coherency (Opcode) Exception ***"
	.align 3
_bfc02598:	.string "*** Floating Point Exception ***"
	.align 3
_bfc025c0:	.string "*** Reserved General Exception ***"
	.align 3
_bfc025e8:	.string "*** Watch Exception ***"
	.align 3
_bfc02600:	.string "*** Virtual Coherency (Data) Exception ***"
	.align 3
_bfc02630:	.string "(null)"
	.align 3
_bfc02638:	.string "\n\nROM: reload requested...\n"
	.align 3
_bfc02658:	.string "ROM: Restarting IOS...\n"
	.align 3
_bfc02670:	.string "trying to read bootvar '%s'\n"
	.align 3
_bfc02690:	.string "trying to set bootvar '%s'\n"
	.align 3
_bfc026b0:	.string "unhandled syscall 0x%x at pc=0x%x (a1=0x%x,a2=0x%x,a3=0x%x)\n"
	.align 3
_bfc026f0:	.string "\n\nROMMON Emulation Microcode\n"
	.align 3
_bfc02710:	.string "ROMMON emulation microcode.\n\n"
	.align 3
_bfc02730:	.string "Microcode has started.\n"
	.align 3
_bfc02748:	.string "The microcode need to be upgraded to match your emulator version.\n"
	.align 3
_bfc02790:	.string "IOS"
	.align 3
_bfc02798:	.string "BOOTLDR"
	.align 3
_bfc027a0:	.string "Launching IOS image at 0x%x...\n"
	.align 3
_bfc027c0:	.string "Image returned to ROM.\n"
	.align 3


	###################################################
	.data
	.align 3
_bfc027d8:	.word _bfc02368
bfc027dc:	.word _bfc00970
bfc027e0:	.word _bfc02380
bfc027e4:	.word 0
bfc027e8:	.word _bfc023a8
bfc027ec:	.word 0
bfc027f0:	.word _bfc023d0
bfc027f4:	.word 0
bfc027f8:	.word _bfc023f0
bfc027fc:	.word 0
bfc02800:	.word _bfc02420
bfc02804:	.word 0
bfc02808:	.word _bfc02448
bfc0280c:	.word 0
bfc02810:	.word _bfc02470
bfc02814:	.word 0
bfc02818:	.word _bfc02498
bfc0281c:	.word _bfc00768
bfc02820:	.word _bfc024b8
bfc02824:	.word 0
bfc02828:	.word _bfc024d8
bfc0282c:	.word 0
bfc02830:	.word _bfc02500
bfc02834:	.word 0
bfc02838:	.word _bfc02528
bfc0283c:	.word 0
bfc02840:	.word _bfc02550
bfc02844:	.word 0
bfc02848:	.word _bfc02568
bfc0284c:	.word 0
bfc02850:	.word _bfc02598
bfc02854:	.word 0
bfc02858:	.word _bfc025c0
bfc0285c:	.word 0
bfc02860:	.word _bfc025c0
bfc02864:	.word 0
bfc02868:	.word _bfc025c0
bfc0286c:	.word 0
bfc02870:	.word _bfc025c0
bfc02874:	.word 0
bfc02878:	.word _bfc025c0
bfc0287c:	.word 0
bfc02880:	.word _bfc025c0
bfc02884:	.word 0
bfc02888:	.word _bfc025c0
bfc0288c:	.word 0
bfc02890:	.word _bfc025e8
bfc02894:	.word 0
bfc02898:	.word _bfc025c0
bfc0289c:	.word 0
bfc028a0:	.word _bfc025c0
bfc028a4:	.word 0
bfc028a8:	.word _bfc025c0
bfc028ac:	.word 0
bfc028b0:	.word _bfc025c0
bfc028b4:	.word 0
bfc028b8:	.word _bfc025c0
bfc028bc:	.word 0
bfc028c0:	.word _bfc025c0
bfc028c4:	.word 0
bfc028c8:	.word _bfc025c0
bfc028cc:	.word 0
bfc028d0:	.word _bfc02600
bfc028d4:	.word 0
_bfc028d8:	.word _bfc026f0
bfc028dc:	.word 0
	.align 3


	#############################################################
	.bss
	.align 3
_a0002000:	.space 4
	.align 3
_a0002008:	.space 8
_a0002010:	.space 4
_a0002014:	.space 4
_a0002018:	.space 4
	.align 3
