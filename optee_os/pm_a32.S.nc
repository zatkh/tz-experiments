#include <arm32_macros_cortex_a9.S>
#include <arm32_macros.S>
#include <arm.h>
#include <asm.S>
#include <generated/asm-defines.h>
#include <keep.h>
#include <kernel/asan.h>
#include <kernel/unwind.h>
#include <platform_config.h>
.section .text
FUNC sm_pm_cpu_suspend, :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	push	{r4 - r12, lr}
	mov	r5, sp
	sub	sp, sp, #SM_PM_CTX_SIZE
	push	{r0, r1}
	mov	r1, r5
	add	r0, sp, #8
	blx	sm_pm_cpu_suspend_save
	adr	lr, aborted
	pop	{r0, pc}
aborted:
	add	sp, sp, #SM_PM_CTX_SIZE
	mov	r0, #(-1)
suspend_return:
	pop	{r4 - r12, pc}
UNWIND(	.fnend)
END_FUNC sm_pm_cpu_suspend
FUNC sm_pm_cpu_do_suspend, :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	push	{r4 - r11}
	read_midr r4
	ubfx	r5, r4, #4, #12
	ldr     r4, =CORTEX_A7_PART_NUM
	cmp	r5, r4
	beq	a7_suspend
	ldr     r4, =CORTEX_A9_PART_NUM
	cmp	r5, r4
	beq	a9_suspend
	b	.
a9_suspend:
	read_pcr r4
	read_diag r5
	stmia	r0!, {r4 - r5}
a7_suspend:
	read_fcseidr r4
	read_tpidruro r5
	stmia	r0!, {r4 - r5}
	read_dacr r4
#ifdef CFG_WITH_LPAE
#error "Not supported"
#else
	read_ttbr0 r5
	read_ttbr1 r6
	read_ttbcr r7
#endif
	read_sctlr r8
	read_actlr r9
	read_cpacr r10
	read_mvbar r11
	stmia	r0!, {r4 - r11}
	read_prrr r4
	read_nmrr r5
	read_vbar r6
	read_nsacr r7
	stmia	r0, {r4 - r7}
	pop	{r4 - r11}
	bx	lr
UNWIND(	.fnend)
END_FUNC sm_pm_cpu_do_suspend
FUNC sm_pm_cpu_resume, :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	cpsid	aif
	adr	r0, _core_pos
	ldr	r1, [r0]
	add	r0, r0, r1
	blx	r0
	adr	r4, _suspend_sp
	ldr	r5, [r4]
	add	r4, r4, r5
	mov_imm r1, THREAD_CORE_LOCAL_SIZE
	mla	r0, r0, r1, r4
	ldr	r0, [r0, #THREAD_CORE_LOCAL_SM_PM_CTX_PHYS]
	ldmia	r0!, {sp, pc}
UNWIND(	.fnend)
END_FUNC sm_pm_cpu_resume
.align 2
.extern thread_core_local
_suspend_sp:
	.long	thread_core_local - .
.extern __get_core_pos
_core_pos:
	.long	__get_core_pos - .
FUNC sm_pm_cpu_do_resume, :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	read_midr r4
	ubfx	r5, r4, #4, #12
	ldr     r4, =CORTEX_A7_PART_NUM
	cmp	r5, r4
	beq	a7_resume
	ldmia   r0!, {r4 - r5}
	write_pcr r4
	write_diag r5
a7_resume:
	mov	ip, #0
	write_iciallu
	write_contextidr ip
	ldmia	r0!, {r4 - r5}
	write_fcseidr r4
	write_tpidruro r5
	ldmia	r0!, {r4 - r11}
	write_tlbiall
	write_dacr r4
#ifdef CFG_WITH_LPAE
#error "Not supported -"
#else
	write_ttbr0 r5
	write_ttbr1 r6
	write_ttbcr r7
#endif
	ldmia	r0, {r4 - r7}
	write_prrr r4
	write_nmrr r5
	write_vbar r6
	write_nsacr r7
	write_actlr r9
	write_cpacr r10
	write_mvbar r11
	write_bpiall
	isb
	dsb
	write_sctlr r8
	isb
	mov	r0, #0
	b	suspend_return
UNWIND(	.fnend)
END_FUNC sm_pm_cpu_do_resume
