#include <asm.S>
#include <kernel/unwind.h>
#include <platform_config.h>
#include <sm/optee_smc.h>
#include <sm/teesmc_opteed.h>
#include <sm/teesmc_opteed_macros.h>
.section .text
.balign 4
.code 32
booted:
	.word	0
FUNC plat_cpu_reset_early , :
UNWIND(	.fnstart)
	ldr	r3, =booted
	ldr	r2, [r3]
	cmp	r2, #0
	moveq	r2, #1
	streq	r2, [r3]
	bxeq	lr
	b	resume_springboard
UNWIND(	.fnend)
END_FUNC plat_cpu_reset_early
LOCAL_FUNC resume_springboard , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	mov	r3, r5
	bl	__get_core_pos
	cmp	r0, #CFG_TEE_CORE_NB_CORE
unhandled_cpu:
	wfige
	bge	unhandled_cpu
	ldr	r1, =stack_tmp_stride
	ldr	r1, [r1]
	mul	r1, r0, r1
	ldr	r0, =stack_tmp_export
	ldr	r0, [r0]
	add	sp, r1, r0
	adr	lr, after_resume
	push	{r4 - r12, lr}
	ldr	r0, =suspend_regs
	bl	sm_pm_cpu_do_resume
after_resume:
	mov	r4, r3
	bl	thread_init_per_cpu
	mov	r0, r4
	bl	init_sec_mon
	bl	main_init_gic
	mov	r0, #TEESMC_OPTEED_RETURN_ENTRY_DONE
	mov	r1, #0
	mov	r2, #0
	mov	r3, #0
	mov	r4, #0
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC resume_springboard
