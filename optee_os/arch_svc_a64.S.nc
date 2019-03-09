#include "tee_syscall_numbers.h"
#include "trace_levels.h"
#include <arm64.h>
#include <arm64_macros.S>
#include <asm.S>
#include <generated/asm-defines.h>
#include <kernel/thread.h>
#include <tee_api_defines.h>
	.section .text.arch_svc_asm
#if 0
struct sc_rec {
	uint64_t x0;
	uint64_t x1;
	uint64_t x19;
	uint64_t x30;
}
#endif
#define SC_REC_X0		(8 * 0)
#define SC_REC_X1		(8 * 1)
#define SC_REC_X19		(8 * 2)
#define SC_REC_X30		(8 * 3)
#define SC_REC_SIZE		(SC_REC_X30 + 8)
FUNC tee_svc_do_call , :
	sub	sp, sp, #SC_REC_SIZE
	stp	x0, x1, [sp, #SC_REC_X0]
	stp	x19, x30, [sp, #SC_REC_X19]
	mov	x19, sp
	ldr	x2, [x0, #THREAD_SVC_REG_SPSR]
	tst	x2, #(SPSR_MODE_RW_32 << SPSR_MODE_RW_SHIFT)
	b.eq	.Lcall_a64
	ldp	x5, x6, [x0, #THREAD_SVC_REG_X5]
	cmp	x6, #0
	b.eq	.Lno_args_a32
	sub	x1, x6, #0x4
	lsl	x1, x1, #3
	lsl	x0, x6, #2
	cmp	x1, x0
	csel	x0, x1, x0, ge
	add	x0, x0, #0xf
	and	x0, x0, #0xfffffffffffffff0
	sub	sp, sp, x0
	mov	x0, sp
	mov	x1, x5
	add	x2, xzr, x6, lsl #2
	bl	tee_svc_copy_from_user
	cmp	x0, #0
	bne	.Lret
	ldr	x0, [x19, #SC_REC_X0]
	ldr	x0, [x0, #THREAD_SVC_REG_X6]
	load_wregs sp, 0, 4, 7
	subs	x2, x0, #0x4
	b.le	.Lno_args_a32
	lsl	x2, x2, #3
	mov	x0, x2
.Lcpy_to_stack:
	ldr	w3, [x1], #4
	str	x3, [x2], #8
	cmp	x2, x19
	b.ne	.Lcpy_to_stack
	mov	sp, x0
.Lno_args_a32: 
	ldr	x9, [x19, #SC_REC_X0]
	load_xregs x9, THREAD_SVC_REG_X0, 0, 3
	mov	w0, w0
	mov	w1, w1
	mov	w2, w2
	mov	w3, w3
	ldr	x16, [x19, #SC_REC_X1]
	blr	x16
	b	.Lret
.Lcall_a64: 
	ldr	x9, [x19, #SC_REC_X0]
	load_xregs x9, THREAD_SVC_REG_X0, 0, 8
	ldr	x16, [x19, #SC_REC_X1]
	blr	x16
.Lret:
	mov	sp, x19
	ldp	x19, x30, [sp, #SC_REC_X19]
	add	sp, sp, #SC_REC_SIZE
	ret
END_FUNC tee_svc_do_call
FUNC syscall_sys_return , :
	mov	x1, #0  
	mov	x2, #0  
	ldr	x3, [x19, #SC_REC_X0] 
	b	tee_svc_sys_return_helper
END_FUNC syscall_sys_return
FUNC syscall_panic , :
	mov	x1, #1  
	mov	x2, x0  
	ldr	w0, =TEE_ERROR_TARGET_DEAD
	ldr	x3, [x19, #SC_REC_X0] 
	b	tee_svc_sys_return_helper
END_FUNC syscall_panic
