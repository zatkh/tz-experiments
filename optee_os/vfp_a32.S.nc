#include <asm.S>
#include <kernel/unwind.h>
	.fpu	neon
FUNC vfp_save_extension_regs , :
UNWIND(	.fnstart)
	vstm	r0!, {d0-d15}
	vstm	r0, {d16-d31}
	bx	lr
UNWIND(	.fnend)
END_FUNC vfp_save_extension_regs
FUNC vfp_restore_extension_regs , :
UNWIND(	.fnstart)
	vldm	r0!, {d0-d15}
	vldm	r0, {d16-d31}
	bx	lr
UNWIND(	.fnend)
END_FUNC vfp_restore_extension_regs
FUNC vfp_write_fpexc , :
UNWIND(	.fnstart)
	vmsr	fpexc, r0
	bx	lr
UNWIND(	.fnend)
END_FUNC vfp_write_fpexc
FUNC vfp_read_fpexc , :
UNWIND(	.fnstart)
	vmrs	r0, fpexc
	bx	lr
UNWIND(	.fnend)
END_FUNC vfp_read_fpexc
FUNC vfp_write_fpscr , :
UNWIND(	.fnstart)
	vmsr	fpscr, r0
	bx	lr
UNWIND(	.fnend)
END_FUNC vfp_write_fpscr
FUNC vfp_read_fpscr , :
UNWIND(	.fnstart)
	vmrs	r0, fpscr
	bx	lr
UNWIND(	.fnend)
END_FUNC vfp_read_fpscr
