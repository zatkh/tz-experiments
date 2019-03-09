	.altmacro
	.macro __do_dregs instr_prefix, instr_suffix, reg_bytes, base_reg, \
			base_offs, reg0, reg1
		.if \reg_bytes == 8
			\instr_prefix\instr_suffix \
				x\reg0, x\reg1, [\base_reg, #\base_offs]
		.else
			\instr_prefix\instr_suffix \
				w\reg0, w\reg1, [\base_reg, #\base_offs]
		.endif
	.endm
	.macro __do_reg instr_prefix, instr_suffix, reg_bytes, base_reg, \
			base_offs, reg
		.if \reg_bytes == 8
			\instr_prefix\instr_suffix \
				x\reg, [\base_reg, #\base_offs]
		.else
			\instr_prefix\instr_suffix \
				w\reg, [\base_reg, #\base_offs]
		.endif
	.endm
	.macro _do_regs instr_prefix, reg_bytes, base_reg, base_offs, \
			from_regnum, to_regnum
		.if (\to_regnum - \from_regnum + 1) >= 2
			__do_dregs \instr_prefix, p, \reg_bytes, \base_reg, \
				\base_offs, \from_regnum, %(\from_regnum + 1)
		.else
			__do_reg \instr_prefix, r, \reg_bytes, \base_reg, \
				\base_offs, \from_regnum
		.endif
		.if (\to_regnum - \from_regnum + 1) > 2
			_do_regs \instr_prefix, \reg_bytes, \base_reg, \
				%(\base_offs + 2 * \reg_bytes), \
				%(\from_regnum + 2), \to_regnum
		.endif
	.endm
	.macro store_xregs base_reg, base_offs, from_regnum, to_regnum
		_do_regs st 8 \base_reg, \base_offs, \from_regnum, \to_regnum
	.endm
	.macro store_wregs base_reg, base_offs, from_regnum, to_regnum
		_do_regs st 4 \base_reg, \base_offs, \from_regnum, \to_regnum
	.endm
	.macro load_xregs base_reg, base_offs, from_regnum, to_regnum
		_do_regs ld 8 \base_reg, \base_offs, \from_regnum, \to_regnum
	.endm
	.macro load_wregs base_reg, base_offs, from_regnum, to_regnum
		_do_regs ld 4 \base_reg, \base_offs, \from_regnum, \to_regnum
	.endm
	.macro  push, r1, r2
	stp     \r1, \r2, [sp, #-16]!
	.endm
	.macro  pop, r1, r2
	ldp     \r1, \r2, [sp], #16
	.endm
	.macro mov_imm _reg, _val
	.if (((\_val) >> 31) == 0 || ((\_val) >> 31) == 0x1ffffffff)
		movz    \_reg, :abs_g1_s:\_val
	.else
		.if (((\_val) >> 47) == 0 || ((\_val) >> 47) == 0x1ffff)
			movz    \_reg, :abs_g2_s:\_val
		.else
			movz    \_reg, :abs_g3:\_val
			movk    \_reg, :abs_g2_nc:\_val
		.endif
		movk    \_reg, :abs_g1_nc:\_val
	.endif
		movk    \_reg, :abs_g0_nc:\_val
	.endm
	.macro adr_l reg, sym
	adrp	\reg, \sym
	add	\reg, \reg, :lo12:\sym
	.endm
