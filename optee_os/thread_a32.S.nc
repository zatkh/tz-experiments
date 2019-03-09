#include <arm32_macros.S>
#include <arm.h>
#include <asm.S>
#include <generated/asm-defines.h>
#include <keep.h>
#include <kernel/abort.h>
#include <kernel/thread_defs.h>
#include <kernel/unwind.h>
#include <mm/core_mmu.h>
#include <sm/optee_smc.h>
#include <sm/teesmc_opteed.h>
#include <sm/teesmc_opteed_macros.h>
#include "thread_private.h"
	.macro cmp_spsr_user_mode reg:req
		tst	\reg, #0x0f
	.endm
LOCAL_FUNC vector_std_smc_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	push	{r0-r7}
	mov	r0, sp
	bl	thread_handle_std_smc
	pop	{r1-r8}
	ldr	r0, =TEESMC_OPTEED_RETURN_CALL_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC vector_std_smc_entry
LOCAL_FUNC vector_fast_smc_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	push	{r0-r7}
	mov	r0, sp
	bl	thread_handle_fast_smc
	pop	{r1-r8}
	ldr	r0, =TEESMC_OPTEED_RETURN_CALL_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC vector_fast_smc_entry
LOCAL_FUNC vector_fiq_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	bl	thread_check_canaries
	ldr	lr, =thread_nintr_handler_ptr
 	ldr	lr, [lr]
 	blx	lr
	mov	r1, r0
	ldr	r0, =TEESMC_OPTEED_RETURN_FIQ_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC vector_fiq_entry
LOCAL_FUNC vector_cpu_on_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	ldr	lr, =thread_cpu_on_handler_ptr
	ldr	lr, [lr]
	blx	lr
	mov	r1, r0
	ldr	r0, =TEESMC_OPTEED_RETURN_ON_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC vector_cpu_on_entry
LOCAL_FUNC vector_cpu_off_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	ldr	lr, =thread_cpu_off_handler_ptr
	ldr	lr, [lr]
	blx	lr
	mov	r1, r0
	ldr	r0, =TEESMC_OPTEED_RETURN_OFF_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC vector_cpu_off_entry
LOCAL_FUNC vector_cpu_suspend_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	ldr	lr, =thread_cpu_suspend_handler_ptr
	ldr	lr, [lr]
	blx	lr
	mov	r1, r0
	ldr	r0, =TEESMC_OPTEED_RETURN_SUSPEND_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC vector_cpu_suspend_entry
LOCAL_FUNC vector_cpu_resume_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	ldr	lr, =thread_cpu_resume_handler_ptr
	ldr	lr, [lr]
	blx	lr
	mov	r1, r0
	ldr	r0, =TEESMC_OPTEED_RETURN_RESUME_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC vector_cpu_resume_entry
LOCAL_FUNC vector_system_off_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	ldr	lr, =thread_system_off_handler_ptr
	ldr	lr, [lr]
	blx	lr
	mov	r1, r0
	ldr	r0, =TEESMC_OPTEED_RETURN_SYSTEM_OFF_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC vector_system_off_entry
LOCAL_FUNC vector_system_reset_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	ldr	lr, =thread_system_reset_handler_ptr
	ldr	lr, [lr]
	blx	lr
	mov	r1, r0
	ldr	r0, =TEESMC_OPTEED_RETURN_SYSTEM_RESET_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC vector_system_reset_entry
FUNC thread_vector_table , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	b	vector_std_smc_entry
	b	vector_fast_smc_entry
	b	vector_cpu_on_entry
	b	vector_cpu_off_entry
	b	vector_cpu_resume_entry
	b	vector_cpu_suspend_entry
	b	vector_fiq_entry
	b	vector_system_off_entry
	b	vector_system_reset_entry
UNWIND(	.fnend)
END_FUNC thread_vector_table
KEEP_PAGER thread_vector_table
FUNC thread_set_abt_sp , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	mrs	r1, cpsr
	cps	#CPSR_MODE_ABT
	mov	sp, r0
	msr	cpsr, r1
	bx	lr
UNWIND(	.fnend)
END_FUNC thread_set_abt_sp
FUNC thread_set_und_sp , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	mrs	r1, cpsr
	cps	#CPSR_MODE_UND
	mov	sp, r0
	msr	cpsr, r1
	bx	lr
UNWIND(	.fnend)
END_FUNC thread_set_und_sp
FUNC thread_set_irq_sp , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	mrs	r1, cpsr
	cps	#CPSR_MODE_IRQ
	mov	sp, r0
	msr	cpsr, r1
	bx	lr
UNWIND(	.fnend)
END_FUNC thread_set_irq_sp
FUNC thread_set_fiq_sp , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	mrs	r1, cpsr
	cps	#CPSR_MODE_FIQ
	mov	sp, r0
	msr	cpsr, r1
	bx	lr
UNWIND(	.fnend)
END_FUNC thread_set_fiq_sp
FUNC thread_resume , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	add	r12, r0, #(13 * 4)	
	cps	#CPSR_MODE_SYS
	ldm	r12!, {sp, lr}
	cps	#CPSR_MODE_SVC
	ldm	r12!, {r1, sp, lr}
	msr	spsr_fsxc, r1
	ldm	r12, {r1, r2}
	cps	#CPSR_MODE_ABT
	cmp_spsr_user_mode r2
	mov	lr, r1
	msr	spsr_fsxc, r2
	ldm	r0, {r0-r12}
	movnes	pc, lr
	b	eret_to_user_mode
UNWIND(	.fnend)
END_FUNC thread_resume
LOCAL_FUNC thread_save_state_fiq , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	mov	r9, lr
	mrs	r8, cpsr
	cpsid	aif			
	push	{r4-r7}
	push	{r0-r3}
	mrs	r6, cpsr		
	bl	thread_get_ctx_regs
	pop	{r1-r4}			
	stm	r0!, {r1-r4}
	pop	{r1-r4}			
	stm	r0!, {r1-r4}
	cps     #CPSR_MODE_SYS
	stm	r0!, {r8-r12}
	stm     r0!, {sp, lr}
	cps     #CPSR_MODE_SVC
	mrs     r1, spsr
	stm     r0!, {r1, sp, lr}
	orr	r6, r6, #ARM32_CPSR_FIA	
	msr	cpsr, r6		
	mov	r0, r8			
	bx	r9
UNWIND(	.fnend)
END_FUNC thread_save_state_fiq
LOCAL_FUNC thread_save_state , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	push	{r12, lr}
	mrs	r12, cpsr
	cpsid	aif			
	push	{r4-r7}
	push	{r0-r3}
	mov	r5, r12			
	mrs	r6, cpsr		
	bl	thread_get_ctx_regs
	pop	{r1-r4}			
	stm	r0!, {r1-r4}
	pop	{r1-r4}			
	stm	r0!, {r1-r4}
	stm	r0!, {r8-r11}
	pop	{r12, lr}
	stm	r0!, {r12}
        cps     #CPSR_MODE_SYS
        stm     r0!, {sp, lr}
        cps     #CPSR_MODE_SVC
        mrs     r1, spsr
        stm     r0!, {r1, sp, lr}
	orr	r6, r6, #ARM32_CPSR_FIA	
	msr	cpsr, r6		
	mov	r0, r5			
	bx	lr
UNWIND(	.fnend)
END_FUNC thread_save_state
FUNC thread_std_smc_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	push	{r0-r7}
	mov	r0, sp
	bl	__thread_std_smc_entry
	pop	{r4-r7}
	add	sp, #(4 * 4)
	cpsid	aif
	bl	thread_get_tmp_sp
	mov	sp, r0
	bl	thread_state_free
	ldr	r0, =TEESMC_OPTEED_RETURN_CALL_DONE
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	mov	r4, r7
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC thread_std_smc_entry
FUNC thread_rpc , :
UNWIND(	.fnstart)
	push	{r4-r5, lr}
UNWIND(	.save	{r4-r5, lr})
	push	{r0}
UNWIND(	.save	{r0})
	bl	thread_save_state
	mov	r4, r0			
	bl	thread_get_tmp_sp
	ldr	r5, [sp]		
	cps	#CPSR_MODE_SVC		
	mov	sp, r0			
	mov	r0, #THREAD_FLAGS_COPY_ARGS_ON_RETURN
	mov	r1, r4			
	ldr	r2, =.thread_rpc_return
	bl	thread_state_suspend
	mov	r4, r0			
	ldr	r0, =TEESMC_OPTEED_RETURN_CALL_DONE
	ldm	r5, {r1-r3}		
	smc	#0
	b	.	
.thread_rpc_return:
	pop	{r12}			
	stm	r12, {r0-r5}		
	pop	{r4-r5, pc}
UNWIND(	.fnend)
END_FUNC thread_rpc
KEEP_PAGER thread_rpc
FUNC thread_smc , :
UNWIND(	.fnstart)
	smc	#0
	bx	lr
UNWIND(	.fnend)
END_FUNC thread_smc
FUNC thread_init_vbar , :
UNWIND(	.fnstart)
	write_vbar r0
	bx	lr
UNWIND(	.fnend)
END_FUNC thread_init_vbar
KEEP_PAGER thread_init_vbar
FUNC __thread_enter_user_mode , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	push    {r4-r12,lr}
	ldr     r4, [sp, #(10 * 0x4)]   
	ldr     r5, [sp, #(11 * 0x4)]   
	ldr     r6, [sp, #(12 * 0x4)]   
	cps	#CPSR_MODE_SYS
	mov	r7, sp
	mov     sp, r4
	cps	#CPSR_MODE_SVC
	push	{r7,r8}
	cpsid	aif
	msr     spsr_fsxc, r6
	mov	lr, r5
	b	eret_to_user_mode
UNWIND(	.fnend)
END_FUNC __thread_enter_user_mode
FUNC thread_unwind_user_mode , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	ldr     ip, [sp, #(15 * 0x4)]   
	str	r1, [ip]
	ldr     ip, [sp, #(16 * 0x4)]   
	str	r2, [ip]
	pop	{r4,r7}
	cps	#CPSR_MODE_SYS
	mov	sp, r4
	cps	#CPSR_MODE_SVC
	pop     {r4-r12,pc}	
UNWIND(	.fnend)
END_FUNC thread_unwind_user_mode
	.macro maybe_restore_mapping
		write_tpidrprw r0
#if defined(CFG_CORE_UNMAP_CORE_AT_EL0) || defined(CFG_WITH_LPAE)
		write_tpidruro r1
#endif
#ifdef CFG_WITH_LPAE
		read_ttbr0_64bit r0, r1
		tst	r1, #BIT(TTBR_ASID_SHIFT - 32)
		beq	11f
#ifdef CFG_CORE_UNMAP_CORE_AT_EL0
		subs	r0, r0, #CORE_MMU_L1_TBL_OFFSET
		sbc	r1, r1, #0
#endif
		bic	r1, r1, #BIT(TTBR_ASID_SHIFT - 32)
		write_ttbr0_64bit r0, r1
		isb
#else 
		read_contextidr r0
		tst	r0, #1
		beq	11f
		bic	r0, r0, #1
		write_contextidr r0
		isb
#ifdef CFG_CORE_UNMAP_CORE_AT_EL0
		read_ttbr1 r0
		sub	r0, r0, #CORE_MMU_L1_TBL_OFFSET
		write_ttbr1 r0
		isb
#endif
#endif 
#ifdef CFG_CORE_UNMAP_CORE_AT_EL0
		ldr	r0, =thread_user_kcode_offset
		ldr	r0, [r0]
		read_vbar r1
		add	r1, r1, r0
		write_vbar r1
		isb
	11:	
		ldr	r0, =22f
		bx	r0
	22:
#else
	11:
#endif
		read_tpidrprw r0
#if defined(CFG_CORE_UNMAP_CORE_AT_EL0) || defined(CFG_WITH_LPAE)
		read_tpidruro r1
#endif
	.endm
.macro	native_intr_handler mode:req
	cpsid	aif
	maybe_restore_mapping
	sub     lr, lr, #4
	.ifc	\mode\(),fiq
	push	{r0-r3, r8-r12, lr}
	.else
	push	{r0-r3, r12, lr}
	.endif
	bl	thread_check_canaries
	ldr	lr, =thread_nintr_handler_ptr
	ldr	lr, [lr]
	blx	lr
	mrs	r0, spsr
	cmp_spsr_user_mode r0
	.ifc	\mode\(),fiq
	pop	{r0-r3, r8-r12, lr}
	.else
	pop	{r0-r3, r12, lr}
	.endif
	movnes	pc, lr
	b	eret_to_user_mode
.endm
.macro foreign_intr_handler mode:req
	cpsid	aif
	maybe_restore_mapping
	sub	lr, lr, #4
	push	{lr}
	push	{r12}
	.ifc	\mode\(),fiq
	bl	thread_save_state_fiq
	.else
	bl	thread_save_state
	.endif
	mov	r0, #THREAD_FLAGS_EXIT_ON_FOREIGN_INTR
	mrs	r1, spsr
	pop	{r12}
	pop	{r2}
	blx	thread_state_suspend
	mov	r4, r0		
	mov	r0, sp
	cps	#CPSR_MODE_SVC
	mov	sp, r0
	ldr	r0, =TEESMC_OPTEED_RETURN_CALL_DONE
	ldr	r1, =OPTEE_SMC_RETURN_RPC_FOREIGN_INTR
	mov	r2, #0
	mov	r3, #0
	smc	#0
	b	.	
.endm
	.section .text.thread_excp_vect
        .align	5
FUNC thread_excp_vect , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	b	.			
	b	thread_und_handler	
	b	thread_svc_handler	
	b	thread_pabort_handler	
	b	thread_dabort_handler	
	b	.			
	b	thread_irq_handler	
	b	thread_fiq_handler	
#ifdef CFG_CORE_WORKAROUND_SPECTRE_BP_SEC
	.macro vector_prologue_spectre
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		write_tpidrprw r0	
	.endm
        .align	5
	.global thread_excp_vect_workaround_a15
thread_excp_vect_workaround_a15:
	vector_prologue_spectre
	mrs	r0, spsr
	cmp_spsr_user_mode r0
	bne	1f
	write_iciallu
	isb
	b	1f
        .align	5
	.global thread_excp_vect_workaround
thread_excp_vect_workaround:
	vector_prologue_spectre
	mrs	r0, spsr
	cmp_spsr_user_mode r0
	bne	1f
	write_bpiall
	isb
1:	and	r0, sp, #(BIT(0) | BIT(1) | BIT(2))
	bic	sp, sp, #(BIT(0) | BIT(1) | BIT(2))
	add	pc, pc, r0, LSL #3
	nop
	read_tpidrprw r0
	b	thread_fiq_handler	
	read_tpidrprw r0
	b	thread_irq_handler	
	read_tpidrprw r0
	b	.			
	read_tpidrprw r0
	b	thread_dabort_handler	
	read_tpidrprw r0
	b	thread_pabort_handler	
	read_tpidrprw r0
	b	thread_svc_handler	
	read_tpidrprw r0
	b	thread_und_handler	
	read_tpidrprw r0
	b	.			
#endif 
thread_und_handler:
	cpsid	aif
	maybe_restore_mapping
	strd	r0, r1, [sp, #THREAD_CORE_LOCAL_R0]
	mrs	r1, spsr
	tst	r1, #CPSR_T
	subne	lr, lr, #2
	subeq	lr, lr, #4
	mov	r0, #ABORT_TYPE_UNDEF
	b	thread_abort_common
thread_dabort_handler:
	cpsid	aif
	maybe_restore_mapping
	strd	r0, r1, [sp, #THREAD_CORE_LOCAL_R0]
	sub	lr, lr, #8
	mov	r0, #ABORT_TYPE_DATA
	b	thread_abort_common
thread_pabort_handler:
	cpsid	aif
	maybe_restore_mapping
	strd	r0, r1, [sp, #THREAD_CORE_LOCAL_R0]
	sub	lr, lr, #4
	mov	r0, #ABORT_TYPE_PREFETCH
thread_abort_common:
	ldr	r1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	lsl	r1, r1, #THREAD_CLF_SAVED_SHIFT
	orr	r1, r1, #THREAD_CLF_ABORT
	tst	r1, #(THREAD_CLF_ABORT << THREAD_CLF_SAVED_SHIFT)
	orrne	r1, r1, #THREAD_CLF_TMP 
	str	r1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	ldrne	r1, [sp, #THREAD_CORE_LOCAL_TMP_STACK_VA_END]
	ldreq	r1, [sp, #THREAD_CORE_LOCAL_ABT_STACK_VA_END]
	stmdb	r1!, {r2-r11, ip}	
	ldrd	r2, r3, [sp, #THREAD_CORE_LOCAL_R0]
	stmdb	r1!, {r2-r3}
	mrs	r3, spsr
	stmdb	r1!, {r2, r3, lr}
	cps	#CPSR_MODE_SYS
	str	lr, [r1, #-4]!
	str	sp, [r1, #-4]!
	mov	sp, r1
	bl	abort_handler
	mov	ip, sp
	ldr	sp, [ip], #4
	ldr	lr, [ip], #4
	cps	#CPSR_MODE_ABT
	ldm	ip!, {r0, r1, lr}	
	msr	spsr_fsxc, r1
	ldr	r0, [sp, #THREAD_CORE_LOCAL_FLAGS]
	lsr	r0, r0, #THREAD_CLF_SAVED_SHIFT
	str	r0, [sp, #THREAD_CORE_LOCAL_FLAGS]
	cmp_spsr_user_mode r1
	ldm	ip, {r0-r11, ip}
	movnes	pc, lr
	b	eret_to_user_mode
thread_svc_handler:
	cpsid	aif
	maybe_restore_mapping
	push	{r0-r7, lr}
	mrs	r0, spsr
	push	{r0}
	mov	r0, sp
	bl	tee_svc_handler
	cpsid	aif	
	pop	{r0}
	msr	spsr_fsxc, r0
	cmp_spsr_user_mode r0
	pop	{r0-r7, lr}
	movnes	pc, lr
	b	eret_to_user_mode
thread_fiq_handler:
#if defined(CFG_ARM_GICV3)
	foreign_intr_handler	fiq
#else
	native_intr_handler	fiq
#endif
thread_irq_handler:
#if defined(CFG_ARM_GICV3)
	native_intr_handler	irq
#else
	foreign_intr_handler	irq
#endif
eret_to_user_mode:
	write_tpidrprw r0
#if defined(CFG_CORE_UNMAP_CORE_AT_EL0) || defined(CFG_WITH_LPAE)
	write_tpidruro r1
#endif
#ifdef CFG_CORE_UNMAP_CORE_AT_EL0
	ldr	r0, =thread_user_kcode_offset
	ldr	r0, [r0]
	read_vbar r1
	sub	r1, r1, r0
	write_vbar r1
	isb
	ldr	r1, =1f
	sub	r1, r1, r0
	bx	r1
1:
#endif 
#ifdef CFG_WITH_LPAE
	read_ttbr0_64bit r0, r1
#ifdef CFG_CORE_UNMAP_CORE_AT_EL0
	add	r0, r0, #CORE_MMU_L1_TBL_OFFSET
#endif
	orr	r1, r1, #BIT(TTBR_ASID_SHIFT - 32)
	write_ttbr0_64bit r0, r1
	isb
#else 
#ifdef CFG_CORE_UNMAP_CORE_AT_EL0
	read_ttbr1 r0
	add	r0, r0, #CORE_MMU_L1_TBL_OFFSET
	write_ttbr1 r0
	isb
#endif
	read_contextidr r0
	orr	r0, r0, #BIT(0)
	write_contextidr r0
	isb
#endif 
	read_tpidrprw r0
#if defined(CFG_CORE_UNMAP_CORE_AT_EL0) || defined(CFG_WITH_LPAE)
	read_tpidruro r1
#endif
	movs	pc, lr
UNWIND(	.fnend)
	.global thread_excp_vect_end
thread_excp_vect_end:
END_FUNC thread_excp_vect
