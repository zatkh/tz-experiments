	.macro read_midr reg
	mrc     p15, 0, \reg, c0, c0, 0
	.endm
	.macro read_ctr reg
	mrc	p15, 0, \reg, c0, c0, 1
	.endm
	.macro read_mpidr reg
	mrc	p15, 0, \reg, c0, c0, 5
	.endm
	.macro read_idpfr1 reg
	mrc	p15, 0, \reg, c0, c1, 1
	.endm
	.macro read_sctlr reg
	mrc	p15, 0, \reg, c1, c0, 0
	.endm
	.macro write_sctlr reg
	mcr	p15, 0, \reg, c1, c0, 0
	.endm
	.macro write_actlr reg
	mcr	p15, 0, \reg, c1, c0, 1
	.endm
	.macro read_actlr reg
	mrc	p15, 0, \reg, c1, c0, 1
	.endm
	.macro write_cpacr reg
	mcr	p15, 0, \reg, c1, c0, 2
	.endm
	.macro read_cpacr reg
	mrc	p15, 0, \reg, c1, c0, 2
	.endm
	.macro read_scr reg
	mrc	p15, 0, \reg, c1, c1, 0
	.endm
	.macro write_scr reg
	mcr	p15, 0, \reg, c1, c1, 0
	.endm
	.macro write_nsacr reg
	mcr	p15, 0, \reg, c1, c1, 2
	.endm
	.macro read_nsacr reg
	mrc	p15, 0, \reg, c1, c1, 2
	.endm
	.macro write_ttbr0 reg
	mcr	p15, 0, \reg, c2, c0, 0
	.endm
	.macro write_ttbr0_64bit reg0, reg1
	mcrr	p15, 0, \reg0, \reg1, cr2
	.endm
	.macro read_ttbr0 reg
	mrc	p15, 0, \reg, c2, c0, 0
	.endm
	.macro read_ttbr0_64bit reg0, reg1
	mrrc	p15, 0, \reg0, \reg1, cr2
	.endm
	.macro write_ttbr1 reg
	mcr	p15, 0, \reg, c2, c0, 1
	.endm
	.macro read_ttbr1 reg
	mrc	p15, 0, \reg, c2, c0, 1
	.endm
	.macro write_ttbcr reg
	mcr	p15, 0, \reg, c2, c0, 2
	.endm
	.macro read_ttbcr reg
	mrc	p15, 0, \reg, c2, c0, 2
	.endm
	.macro write_dacr reg
	mcr	p15, 0, \reg, c3, c0, 0
	.endm
	.macro read_dacr reg
	mrc	p15, 0, \reg, c3, c0, 0
	.endm
	.macro read_dfsr reg
	mrc	p15, 0, \reg, c5, c0, 0
	.endm
	.macro write_icialluis
	mcr	p15, 0, r0, c7, c1, 0
	.endm
	.macro write_bpiallis
	mcr	p15, 0, r0, c7, c1, 6
	.endm
	.macro write_iciallu
	mcr	p15, 0, r0, c7, c5, 0
	.endm
	.macro write_icimvau reg
	mcr	p15, 0, \reg, c7, c5, 1
	.endm
	.macro write_bpiall
	mcr	p15, 0, r0, c7, c5, 6
	.endm
	.macro write_dcimvac reg
	mcr	p15, 0, \reg, c7, c6, 1
	.endm
	.macro write_dcisw reg
	mcr	p15, 0, \reg, c7, c6, 2
	.endm
	.macro write_dccmvac reg
	mcr	p15, 0, \reg, c7, c10, 1
	.endm
	.macro write_dccsw reg
	mcr	p15, 0, \reg, c7, c10, 2
	.endm
	.macro write_dccimvac reg
	mcr	p15, 0, \reg, c7, c14, 1
	.endm
	.macro write_dccisw reg
	mcr	p15, 0, \reg, c7, c14, 2
	.endm
	.macro write_tlbiall
	mcr	p15, 0, r0, c8, c7, 0
	.endm
	.macro write_tlbiallis
	mcr	p15, 0, r0, c8, c3, 0
	.endm
	.macro write_tlbiasidis reg
	mcr	p15, 0, \reg, c8, c3, 2
	.endm
	.macro write_tlbimvaais reg
	mcr	p15, 0, \reg, c8, c3, 3
	.endm
	.macro write_prrr reg
	mcr	p15, 0, \reg, c10, c2, 0
	.endm
	.macro read_prrr reg
	mrc	p15, 0, \reg, c10, c2, 0
	.endm
	.macro write_nmrr reg
	mcr	p15, 0, \reg, c10, c2, 1
	.endm
	.macro read_nmrr reg
	mrc	p15, 0, \reg, c10, c2, 1
	.endm
	.macro read_vbar reg
	mrc	p15, 0, \reg, c12, c0, 0
	.endm
	.macro write_vbar reg
	mcr	p15, 0, \reg, c12, c0, 0
	.endm
	.macro write_mvbar reg
	mcr	p15, 0, \reg, c12, c0, 1
	.endm
	.macro read_mvbar reg
	mrc	p15, 0, \reg, c12, c0, 1
	.endm
	.macro write_fcseidr reg
	mcr	p15, 0, \reg, c13, c0, 0
	.endm
	.macro read_fcseidr reg
	mrc	p15, 0, \reg, c13, c0, 0
	.endm
	.macro write_contextidr reg
	mcr	p15, 0, \reg, c13, c0, 1
	.endm
	.macro read_contextidr reg
	mrc	p15, 0, \reg, c13, c0, 1
	.endm
	.macro write_tpidruro reg
	mcr	p15, 0, \reg, c13, c0, 3
	.endm
	.macro read_tpidruro reg
	mrc	p15, 0, \reg, c13, c0, 3
	.endm
	.macro write_tpidrprw reg
	mcr	p15, 0, \reg, c13, c0, 4
	.endm
	.macro read_tpidrprw reg
	mrc	p15, 0, \reg, c13, c0, 4
	.endm
	.macro write_cntvoff reg0, reg1
	mcrr  p15, 4, \reg0, \reg1, c14
	.endm
	.macro read_clidr reg
	mrc	p15, 1, \reg, c0, c0, 1
	.endm
	.macro read_ccsidr reg
	mrc	p15, 1, \reg, c0, c0, 0
	.endm
	.macro write_csselr reg
	mcr	p15, 2, \reg, c0, c0, 0
	.endm
	.macro mov_imm reg, val
		.if ((\val) & 0xffff0000) == 0
			movw	\reg, #(\val)
		.else
			movw	\reg, #((\val) & 0xffff)
			movt	\reg, #((\val) >> 16)
		.endif
	.endm
