	.macro write_pcr reg
	mcr  p15, 0, \reg, c15, c0, 0
	.endm
	.macro read_pcr reg
	mrc  p15, 0, \reg, c15, c0, 0
	.endm
	.macro write_diag reg
	mcr  p15, 0, \reg, c15, c0, 1
	.endm
	.macro read_diag reg
	mrc  p15, 0, \reg, c15, c0, 1
	.endm
