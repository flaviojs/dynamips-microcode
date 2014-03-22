SECTIONS {
	.text 0xBFC00000 : { *(.text) }
	.rodata : { *(.rodata) }
	.data : { *(.data) }
	.bss 0xA0002000 : { *(.bss)  *(COMMON) }
}
