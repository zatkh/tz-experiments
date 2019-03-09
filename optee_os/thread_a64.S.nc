#include <arm.h>
#include <arm64_macros.S>
#include <asm.S>
#include <generated/asm-defines.h>
#include <keep.h>
#include <kernel/thread_defs.h>
#include <mm/core_mmu.h>
#include <smccc.h>
#include <sm/optee_smc.h>
#include <sm/teesmc_opteed.h>
#include <sm/teesmc_opteed_macros.h>
#include "thread_private.h"
	.macro get_thread_ctx core_local, res, tmp0, tmp1
		ldr	w\tmp0, [\core_local, \
				#THREAD_CORE_LOCAL_CURR_THREAD]
		adr	x\res, threads
		mov	x\tmp1, #THREAD_CTX_SIZE
		madd	x\res, x\tmp0, x\tmp1, x\res
	.endm
	.macro b_if_spsr_is_el0 reg, label
		tbnz	\reg, #(SPSR_MODE_RW_32 << SPSR_MODE_RW_SHIFT), \label
		tst	\reg, #(SPSR_64_MODE_EL_MASK << SPSR_64_MODE_EL_SHIFT)
		b.eq	\label
	.endm
LOCAL_FUNC vector_std_smc_entry , :
	sub	sp, sp, #THREAD_SMC_ARGS_SIZE
	store_xregs sp, THREAD_SMC_ARGS_X0, 0, 7
	mov	x0, sp
	bl	thread_handle_std_smc
	load_xregs sp, THREAD_SMC_ARGS_X0, 1, 8
	add	sp, sp, #THREAD_SMC_ARGS_SIZE
	ldr	x0, =TEESMC_OPTEED_RETURN_CALL_DONE
	smc	#0
	b	.	
END_FUNC vector_std_smc_entry
LOCAL_FUNC vector_fast_smc_entry , :
	sub	sp, sp, #THREAD_SMC_ARGS_SIZE
	store_xregs sp, THREAD_SMC_ARGS_X0, 0, 7
	mov	x0, sp
	bl	thread_handle_fast_smc
	load_xregs sp, THREAD_SMC_ARGS_X0, 1, 8
	add	sp, sp, #THREAD_SMC_ARGS_SIZE
	ldr	x0, =TEESMC_OPTEED_RETURN_CALL_DONE
	smc	#0
	b	.	
END_FUNC vector_fast_smc_entry
LOCAL_FUNC vector_fiq_entry , :
	bl	thread_check_canaries
	adr	x16, thread_nintr_handler_ptr
	ldr	x16, [x16]
	blr	x16
	ldr	x0, =TEESMC_OPTEED_RETURN_FIQ_DONE
	smc	#0
	b	.	
END_FUNC vector_fiq_entry
LOCAL_FUNC vector_cpu_on_entry , :
	adr	x16, thread_cpu_on_handler_ptr
	ldr	x16, [x16]
	blr	x16
	mov	x1, x0
	ldr	x0, =TEESMC_OPTEED_RETURN_ON_DONE
	smc	#0
	b	.	
END_FUNC vector_cpu_on_entry
LOCAL_FUNC vector_cpu_off_entry , :
	adr	x16, thread_cpu_off_handler_ptr
	ldr	x16, [x16]
	blr	x16
	mov	x1, x0
	ldr	x0, =TEESMC_OPTEED_RETURN_OFF_DONE
	smc	#0
	b	.	
END_FUNC vector_cpu_off_entry
LOCAL_FUNC vector_cpu_suspend_entry , :
	adr	x16, thread_cpu_suspend_handler_ptr
	ldr	x16, [x16]
	blr	x16
	mov	x1, x0
	ldr	x0, =TEESMC_OPTEED_RETURN_SUSPEND_DONE
	smc	#0
	b	.	
END_FUNC vector_cpu_suspend_entry
LOCAL_FUNC vector_cpu_resume_entry , :
	adr	x16, thread_cpu_resume_handler_ptr
	ldr	x16, [x16]
	blr	x16
	mov	x1, x0
	ldr	x0, =TEESMC_OPTEED_RETURN_RESUME_DONE
	smc	#0
	b	.	
END_FUNC vector_cpu_resume_entry
LOCAL_FUNC vector_system_off_entry , :
	adr	x16, thread_system_off_handler_ptr
	ldr	x16, [x16]
	blr	x16
	mov	x1, x0
	ldr	x0, =TEESMC_OPTEED_RETURN_SYSTEM_OFF_DONE
	smc	#0
	b	.	
END_FUNC vector_system_off_entry
LOCAL_FUNC vector_system_reset_entry , :
	adr	x16, thread_system_reset_handler_ptr
	ldr	x16, [x16]
	blr	x16
	mov	x1, x0
	ldr	x0, =TEESMC_OPTEED_RETURN_SYSTEM_RESET_DONE
	smc	#0
	b	.	
END_FUNC vector_system_reset_entry
FUNC thread_vector_table , :
	b	vector_std_smc_entry
	b	vector_fast_smc_entry
	b	vector_cpu_on_entry
	b	vector_cpu_off_entry
	b	vector_cpu_resume_entry
	b	vector_cpu_suspend_entry
	b	vector_fiq_entry
	b	vector_system_off_entry
	b	vector_system_reset_entry
END_FUNC thread_vector_table
KEEP_PAGER thread_vector_table
FUNC thread_resume , :
	load_xregs x0, THREAD_CTX_REGS_SP, 1, 3
	load_xregs x0, THREAD_CTX_REGS_X4, 4, 30
	mov	sp, x1
	msr	elr_el1, x2
	msr	spsr_el1, x3
	b_if_spsr_is_el0 w3, 1f
	load_xregs x0, THREAD_CTX_REGS_X1, 1, 3
	ldr	x0, [x0, THREAD_CTX_REGS_X0]
	eret
1:	load_xregs x0, THREAD_CTX_REGS_X1, 1, 3
	ldr	x0, [x0, THREAD_CTX_REGS_X0]
	msr	spsel, #1
	store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 1
	b	eret_to_el0
END_FUNC thread_resume
FUNC thread_std_smc_entry , :
	sub	sp, sp, #THREAD_SMC_ARGS_SIZE
	store_xregs sp, THREAD_SMC_ARGS_X0, 0, 7
	mov	x0, sp
	bl	__thread_std_smc_entry
	load_xregs sp, THREAD_SMC_ARGS_X0, 20, 23
	add	sp, sp, #THREAD_SMC_ARGS_SIZE
	msr	daifset, #DAIFBIT_ALL
	bl	thread_get_tmp_sp
	mov	sp, x0
	bl	thread_state_free
	ldr	x0, =TEESMC_OPTEED_RETURN_CALL_DONE
	mov	x1, x20
	mov	x2, x21
	mov	x3, x22
	mov	x4, x23
	smc	#0
	b	.	
END_FUNC thread_std_smc_entry
FUNC thread_rpc , :
	mrs	x1, daif
	orr	x1, x1, #(SPSR_64_MODE_EL1 << SPSR_64_MODE_EL_SHIFT)
	msr	daifset, #DAIFBIT_ALL
	push	x0, xzr
	push	x1, x30
	bl	thread_get_ctx_regs
	ldr	x30, [sp, #8]
	store_xregs x0, THREAD_CTX_REGS_X19, 19, 30
	mov	x19, x0
	bl	thread_get_tmp_sp
	pop	x1, xzr		
	mov	x2, sp
	str	x2, [x19, #THREAD_CTX_REGS_SP]
	ldr	x20, [sp]	
	mov	sp, x0		
	adr	x2, .thread_rpc_return
	mov	w0, #THREAD_FLAGS_COPY_ARGS_ON_RETURN
	bl	thread_state_suspend
	mov	x4, x0		
	ldr	w0, =TEESMC_OPTEED_RETURN_CALL_DONE
	load_wregs x20, 0, 1, 3	
	smc	#0
	b	.		
.thread_rpc_return:
	pop	x16, xzr	
	store_wregs x16, 0, 0, 5	
	ret
END_FUNC thread_rpc
KEEP_PAGER thread_rpc
FUNC thread_smc , :
	smc	#0
	ret
END_FUNC thread_smc
FUNC thread_init_vbar , :
	msr	vbar_el1, x0
	ret
END_FUNC thread_init_vbar
KEEP_PAGER thread_init_vbar
FUNC __thread_enter_user_mode , :
	ldr	x8, [sp]
	sub	sp, sp, #THREAD_USER_MODE_REC_SIZE
	store_xregs sp, THREAD_USER_MODE_REC_EXIT_STATUS0_PTR, 7, 8
	store_xregs sp, THREAD_USER_MODE_REC_X19, 19, 30
	msr	daifset, #DAIFBIT_ALL
	mov	x19, sp
	msr	spsel, #1
	get_thread_ctx sp, 21, 20, 22
	str	x19, [x21, #THREAD_CTX_KERN_SP]
	msr	spsr_el1, x6
	mov	x13, x4		
	msr	sp_el0, x4	
	msr	elr_el1, x5
	mov x29, #0
	store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 1
	b eret_to_el0
END_FUNC __thread_enter_user_mode
FUNC thread_unwind_user_mode , :
	ldp	x3, x4, [sp, #THREAD_USER_MODE_REC_EXIT_STATUS0_PTR]
	str	w1, [x3]
	str	w2, [x4]
	load_xregs sp, THREAD_USER_MODE_REC_X19, 19, 30
	add	sp, sp, #THREAD_USER_MODE_REC_SIZE
	ret
END_FUNC thread_unwind_user_mode
	.macro check_vector_size since
	  .if (. - \since) > (32 * 4)
	    .error "Vector exceeds 32 instructions"
	  .endif
	.endm
	.macro restore_mapping
#ifdef CFG_CORE_UNMAP_CORE_AT_EL0
		msr	tpidr_el1, x0
		msr	tpidrro_el0, x1
		mrs	x0, ttbr0_el1
		sub	x0, x0, #CORE_MMU_L1_TBL_OFFSET
		bic	x0, x0, #BIT(TTBR_ASID_SHIFT)
		msr	ttbr0_el1, x0
		isb
		ldr	x0, =1f
		br	x0
	1:
		adr	x0, thread_user_kcode_offset
		ldr	x0, [x0]
		mrs	x1, vbar_el1
		add	x1, x1, x0
		msr	vbar_el1, x1
		isb
#ifdef CFG_CORE_WORKAROUND_SPECTRE_BP_SEC
		adr	x0, thread_user_kdata_sp_offset
		ldr	x0, [x0]
		add	sp, sp, x0
#endif
		mrs	x0, tpidr_el1
		mrs	x1, tpidrro_el0
		store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
#else
		store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
		mrs	x0, ttbr0_el1
		bic	x0, x0, #BIT(TTBR_ASID_SHIFT)
		msr	ttbr0_el1, x0
		isb
#endif 
	.endm
#define INV_INSN	0
	.section .text.thread_excp_vect
	.align	11, INV_INSN
FUNC thread_excp_vect , :
	.align	7, INV_INSN
el1_sync_sp0:
	store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
	b	el1_sync_abort
	check_vector_size el1_sync_sp0
	.align	7, INV_INSN
el1_irq_sp0:
	store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
	b	elx_irq
	check_vector_size el1_irq_sp0
	.align	7, INV_INSN
el1_fiq_sp0:
	store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
	b	elx_fiq
	check_vector_size el1_fiq_sp0
	.align	7, INV_INSN
el1_serror_sp0:
	b	el1_serror_sp0
	check_vector_size el1_serror_sp0
	.align	7, INV_INSN
el1_sync_sp1:
	b	el1_sync_sp1
	check_vector_size el1_sync_sp1
	.align	7, INV_INSN
el1_irq_sp1:
	b	el1_irq_sp1
	check_vector_size el1_irq_sp1
	.align	7, INV_INSN
el1_fiq_sp1:
	b	el1_fiq_sp1
	check_vector_size el1_fiq_sp1
	.align	7, INV_INSN
el1_serror_sp1:
	b	el1_serror_sp1
	check_vector_size el1_serror_sp1
	.align	7, INV_INSN
el0_sync_a64:
	restore_mapping
	mrs	x2, esr_el1
	mrs	x3, sp_el0
	lsr	x2, x2, #ESR_EC_SHIFT
	cmp	x2, #ESR_EC_AARCH64_SVC
	b.eq	el0_svc
	b	el0_sync_abort
	check_vector_size el0_sync_a64
	.align	7, INV_INSN
el0_irq_a64:
	restore_mapping
	b	elx_irq
	check_vector_size el0_irq_a64
	.align	7, INV_INSN
el0_fiq_a64:
	restore_mapping
	b	elx_fiq
	check_vector_size el0_fiq_a64
	.align	7, INV_INSN
el0_serror_a64:
	b   	el0_serror_a64
	check_vector_size el0_serror_a64
	.align	7, INV_INSN
el0_sync_a32:
	restore_mapping
	mrs	x2, esr_el1
	mrs	x3, sp_el0
	lsr	x2, x2, #ESR_EC_SHIFT
	cmp	x2, #ESR_EC_AARCH32_SVC
	b.eq	el0_svc
	b	el0_sync_abort
	check_vector_size el0_sync_a32
	.align	7, INV_INSN
el0_irq_a32:
	restore_mapping
	b	elx_irq
	check_vector_size el0_irq_a32
	.align	7, INV_INSN
el0_fiq_a32:
	restore_mapping
	b	elx_fiq
	check_vector_size el0_fiq_a32
	.align	7, INV_INSN
el0_serror_a32:
	b	el0_serror_a32
	check_vector_size el0_serror_a32
#if defined(CFG_CORE_WORKAROUND_SPECTRE_BP_SEC)
	.macro invalidate_branch_predictor
		store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
		mov_imm	x0, SMCCC_ARCH_WORKAROUND_1
		smc	#0
		load_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
	.endm
	.align	11, INV_INSN
	.global thread_excp_vect_workaround
thread_excp_vect_workaround:
	.align	7, INV_INSN
workaround_el1_sync_sp0:
	b	el1_sync_sp0
	check_vector_size workaround_el1_sync_sp0
	.align	7, INV_INSN
workaround_el1_irq_sp0:
	b	el1_irq_sp0
	check_vector_size workaround_el1_irq_sp0
	.align	7, INV_INSN
workaround_el1_fiq_sp0:
	b	el1_fiq_sp0
	check_vector_size workaround_el1_fiq_sp0
	.align	7, INV_INSN
workaround_el1_serror_sp0:
	b	el1_serror_sp0
	check_vector_size workaround_el1_serror_sp0
	.align	7, INV_INSN
workaround_el1_sync_sp1:
	b	workaround_el1_sync_sp1
	check_vector_size workaround_el1_sync_sp1
	.align	7, INV_INSN
workaround_el1_irq_sp1:
	b	workaround_el1_irq_sp1
	check_vector_size workaround_el1_irq_sp1
	.align	7, INV_INSN
workaround_el1_fiq_sp1:
	b	workaround_el1_fiq_sp1
	check_vector_size workaround_el1_fiq_sp1
	.align	7, INV_INSN
workaround_el1_serror_sp1:
	b	workaround_el1_serror_sp1
	check_vector_size workaround_el1_serror_sp1
	.align	7, INV_INSN
workaround_el0_sync_a64:
	invalidate_branch_predictor
	b	el0_sync_a64
	check_vector_size workaround_el0_sync_a64
	.align	7, INV_INSN
workaround_el0_irq_a64:
	invalidate_branch_predictor
	b	el0_irq_a64
	check_vector_size workaround_el0_irq_a64
	.align	7, INV_INSN
workaround_el0_fiq_a64:
	invalidate_branch_predictor
	b	el0_fiq_a64
	check_vector_size workaround_el0_fiq_a64
	.align	7, INV_INSN
workaround_el0_serror_a64:
	b   	workaround_el0_serror_a64
	check_vector_size workaround_el0_serror_a64
	.align	7, INV_INSN
workaround_el0_sync_a32:
	invalidate_branch_predictor
	b	el0_sync_a32
	check_vector_size workaround_el0_sync_a32
	.align	7, INV_INSN
workaround_el0_irq_a32:
	invalidate_branch_predictor
	b	el0_irq_a32
	check_vector_size workaround_el0_irq_a32
	.align	7, INV_INSN
workaround_el0_fiq_a32:
	invalidate_branch_predictor
	b	el0_fiq_a32
	check_vector_size workaround_el0_fiq_a32
	.align	7, INV_INSN
workaround_el0_serror_a32:
	b	workaround_el0_serror_a32
	check_vector_size workaround_el0_serror_a32
#endif 
eret_to_el0:
#ifdef CFG_CORE_UNMAP_CORE_AT_EL0
	adr	x0, thread_user_kcode_offset
	ldr	x0, [x0]
	mrs	x1, vbar_el1
	sub	x1, x1, x0
	msr	vbar_el1, x1
	isb
#ifdef CFG_CORE_WORKAROUND_SPECTRE_BP_SEC
	adr	x1, thread_user_kdata_sp_offset
	ldr	x1, [x1]
	msr	tpidr_el1, x1
#endif
	ldr	x1, =1f
	sub	x1, x1, x0
	br	x1
1:
	load_xregs sp, THREAD_CORE_LOCAL_X0, 0, 1
	msr	tpidrro_el0, x0
	mrs	x0, ttbr0_el1
	add	x0, x0, #CORE_MMU_L1_TBL_OFFSET
	orr	x0, x0, #BIT(TTBR_ASID_SHIFT) 
	msr	ttbr0_el1, x0
	isb
#ifdef CFG_CORE_WORKAROUND_SPECTRE_BP_SEC
	mrs	x0, tpidr_el1
	sub	sp, sp, x0
#endif
	mrs	x0, tpidrro_el0
#else
	mrs	x0, ttbr0_el1
	orr	x0, x0, #BIT(TTBR_ASID_SHIFT) 
	msr	ttbr0_el1, x0
	isb
	load_xregs sp, THREAD_CORE_LOCAL_X0, 0, 1
#endif 
	eret
	.global thread_excp_vect_end
thread_excp_vect_end:
END_FUNC thread_excp_vect
LOCAL_FUNC el0_svc , :
	get_thread_ctx sp, 0, 1, 2
	ldr	x0, [x0, #THREAD_CTX_KERN_SP]
	mov	x1, sp
	msr	spsel, #0
	mov	x2, sp	
	mov	sp, x0
	sub	sp, sp, #THREAD_SVC_REG_SIZE
	stp	x30,x2, [sp, #THREAD_SVC_REG_X30]
	ldp	x2, x3, [x1, #THREAD_CORE_LOCAL_X2]
	ldp	x0, x1, [x1, #THREAD_CORE_LOCAL_X0]
	store_xregs sp, THREAD_SVC_REG_X0, 0, 14
	mrs	x0, elr_el1
	mrs	x1, spsr_el1
	store_xregs sp, THREAD_SVC_REG_ELR, 0, 1
	mov	x0, sp
#if defined(CFG_ARM_GICV3)
	msr	daifclr, #(DAIFBIT_IRQ | DAIFBIT_ABT | DAIFBIT_DBG)
#else
	msr	daifclr, #(DAIFBIT_FIQ | DAIFBIT_ABT | DAIFBIT_DBG)
#endif
	bl	tee_svc_handler
	msr	daifset, #DAIFBIT_ALL
	msr	spsel, #1
	get_thread_ctx sp, 0, 1, 2
	msr	spsel, #0
	add	x1, sp, #THREAD_SVC_REG_SIZE
	str	x1, [x0, #THREAD_CTX_KERN_SP]
	load_xregs sp, THREAD_SVC_REG_ELR, 0, 1
	msr	elr_el1, x0
	msr	spsr_el1, x1
	load_xregs sp, THREAD_SVC_REG_X2, 2, 14
	mov	x30, sp
	ldr	x0, [x30, #THREAD_SVC_REG_SP_EL0]
	mov	sp, x0
	b_if_spsr_is_el0 w1, 1f
	ldp	x0, x1, [x30, THREAD_SVC_REG_X0]
	ldr	x30, [x30, #THREAD_SVC_REG_X30]
	eret
1:	ldp	x0, x1, [x30, THREAD_SVC_REG_X0]
	ldr	x30, [x30, #THREAD_SVC_REG_X30]
	msr	spsel, #1
	store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 1
	b	eret_to_el0
END_FUNC el0_svc
LOCAL_FUNC el1_sync_abort , :
	mov	x0, sp
	msr	spsel, #0
	mov	x3, sp		
	ldr	w1, [x0, #THREAD_CORE_LOCAL_FLAGS]
	lsl	w1, w1, #THREAD_CLF_SAVED_SHIFT
	orr	w1, w1, #THREAD_CLF_ABORT
	tbnz	w1, #(THREAD_CLF_SAVED_SHIFT + THREAD_CLF_ABORT_SHIFT), \
			.Lsel_tmp_sp
	ldr	x2, [x0, #THREAD_CORE_LOCAL_ABT_STACK_VA_END]
	b	.Lset_sp
.Lsel_tmp_sp:
	ldr	x2, [x0, #THREAD_CORE_LOCAL_TMP_STACK_VA_END]
	orr	w1, w1, #THREAD_CLF_TMP	
.Lset_sp:
	mov	sp, x2
	str	w1, [x0, #THREAD_CORE_LOCAL_FLAGS]
	sub	sp, sp, #THREAD_ABT_REGS_SIZE
	mrs	x2, spsr_el1
	stp	x2, x3, [sp, #THREAD_ABT_REG_SPSR]
	ldp	x2, x3, [x0, #THREAD_CORE_LOCAL_X0]
	stp	x2, x3, [sp, #THREAD_ABT_REG_X0]
	ldp	x2, x3, [x0, #THREAD_CORE_LOCAL_X2]
	store_xregs sp, THREAD_ABT_REG_X2, 2, 29
	mrs	x0, elr_el1
	stp	x30, x0, [sp, #THREAD_ABT_REG_X30]
	mov	x0, #0
	mov	x1, sp
	bl	abort_handler
	ldp	x30, x0, [sp, #THREAD_ABT_REG_X30]
	msr	elr_el1, x0
	load_xregs sp, THREAD_ABT_REG_X0, 0, 29
	msr	spsel, #1
	store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
	mrs	x3, sp_el0
	ldp	x0, x1, [x3, #THREAD_ABT_REG_SPSR]
	msr	spsr_el1, x0
	msr	sp_el0, x1
	ldr	w0, [sp, #THREAD_CORE_LOCAL_FLAGS]
	lsr	w0, w0, #THREAD_CLF_SAVED_SHIFT
	str	w0, [sp, #THREAD_CORE_LOCAL_FLAGS]
	load_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
	eret
END_FUNC el1_sync_abort
LOCAL_FUNC el0_sync_abort , :
	ldr	w1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	lsl	w1, w1, #THREAD_CLF_SAVED_SHIFT
	orr	w1, w1, #THREAD_CLF_ABORT
	str	w1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	ldr	x1, [sp, #THREAD_CORE_LOCAL_ABT_STACK_VA_END]
	mov	x0, sp
	msr	spsel, #0
	mov	sp, x1
	sub	sp, sp, #THREAD_ABT_REGS_SIZE
	mrs	x2, spsr_el1
	stp	x2, x3, [sp, #THREAD_ABT_REG_SPSR]
	ldp	x2, x3, [x0, #THREAD_CORE_LOCAL_X0]
	stp	x2, x3, [sp, #THREAD_ABT_REG_X0]
	ldp	x2, x3, [x0, #THREAD_CORE_LOCAL_X2]
	store_xregs sp, THREAD_ABT_REG_X2, 2, 29
	mrs	x0, elr_el1
	stp	x30, x0, [sp, #THREAD_ABT_REG_X30]
	mov	x0, #0
	mov	x1, sp
	bl	abort_handler
	ldp	x30, x0, [sp, #THREAD_ABT_REG_X30]
	msr	elr_el1, x0
	load_xregs sp, THREAD_ABT_REG_X0, 0, 29
	msr	spsel, #1
	store_xregs sp, THREAD_CORE_LOCAL_X0, 0, 3
	mrs	x3, sp_el0
	ldp	x0, x1, [x3, #THREAD_ABT_REG_SPSR]
	msr	spsr_el1, x0
	msr	sp_el0, x1
	ldr	w1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	lsr	w1, w1, #THREAD_CLF_SAVED_SHIFT
	str	w1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	load_xregs sp, THREAD_CORE_LOCAL_X2, 2, 3
	b_if_spsr_is_el0 w0, 1f
	load_xregs sp, THREAD_CORE_LOCAL_X0, 0, 1
	eret
1:	b	eret_to_el0
END_FUNC el0_sync_abort
.macro foreign_intr_handler mode:req
	ldr	w1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	lsl	w1, w1, #THREAD_CLF_SAVED_SHIFT
	orr	w1, w1, #THREAD_CLF_TMP
	.ifc	\mode\(),fiq
	orr	w1, w1, #THREAD_CLF_FIQ
	.else
	orr	w1, w1, #THREAD_CLF_IRQ
	.endif
	str	w1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	get_thread_ctx sp, 0, 1, 2
	mrs	x2, sp_el0
	str	x2, [x0, #THREAD_CTX_REGS_SP]
	store_xregs x0, THREAD_CTX_REGS_X4, 4, 30
	load_xregs sp, THREAD_CORE_LOCAL_X0, 10, 13
	store_xregs x0, THREAD_CTX_REGS_X0, 10, 13
	ldr	x1, [sp, #THREAD_CORE_LOCAL_TMP_STACK_VA_END]
	msr	spsel, #0
	mov	sp, x1
	mov	w0, #THREAD_FLAGS_EXIT_ON_FOREIGN_INTR
	mrs	x1, spsr_el1
	mrs	x2, elr_el1
	bl	thread_state_suspend
	mov	w4, w0		
	msr	spsel, #1
	ldr	w0, [sp, #THREAD_CORE_LOCAL_FLAGS]
	lsr	w0, w0, #THREAD_CLF_SAVED_SHIFT
	str	w0, [sp, #THREAD_CORE_LOCAL_FLAGS]
	msr	spsel, #0
	ldr	w0, =TEESMC_OPTEED_RETURN_CALL_DONE
	ldr	w1, =OPTEE_SMC_RETURN_RPC_FOREIGN_INTR
	mov	w2, #0
	mov	w3, #0
	smc	#0
	b	.	
.endm
#define ELX_NINTR_REC_X(x)		(8 * ((x) - 4))
#define ELX_NINTR_REC_LR		(8 + ELX_NINTR_REC_X(19))
#define ELX_NINTR_REC_SP_EL0		(8 + ELX_NINTR_REC_LR)
#define ELX_NINTR_REC_SIZE		(8 + ELX_NINTR_REC_SP_EL0)
.macro native_intr_handler mode:req
	ldr	w1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	lsl	w1, w1, #THREAD_CLF_SAVED_SHIFT
	.ifc	\mode\(),fiq
	orr	w1, w1, #THREAD_CLF_FIQ
	.else
	orr	w1, w1, #THREAD_CLF_IRQ
	.endif
	orr	w1, w1, #THREAD_CLF_TMP
	str	w1, [sp, #THREAD_CORE_LOCAL_FLAGS]
	ldr	x1, [sp, #THREAD_CORE_LOCAL_TMP_STACK_VA_END]
	mrs	x2, sp_el0
	msr	spsel, #0
	mov	sp, x1
	sub	sp, sp, #ELX_NINTR_REC_SIZE
	store_xregs sp, ELX_NINTR_REC_X(4), 4, 18
	stp	x30, x2, [sp, #ELX_NINTR_REC_LR]
	bl	thread_check_canaries
	adr	x16, thread_nintr_handler_ptr
	ldr	x16, [x16]
	blr	x16
	load_xregs sp, ELX_NINTR_REC_X(4), 4, 18
	ldp	x30, x2, [sp, #ELX_NINTR_REC_LR]
	mov	sp, x2
	msr	spsel, #1
	ldr	w0, [sp, #THREAD_CORE_LOCAL_FLAGS]
	lsr	w0, w0, #THREAD_CLF_SAVED_SHIFT
	str	w0, [sp, #THREAD_CORE_LOCAL_FLAGS]
	mrs	x0, spsr_el1
	load_xregs sp, THREAD_CORE_LOCAL_X2, 2, 3
	b_if_spsr_is_el0 w0, 1f
	load_xregs sp, THREAD_CORE_LOCAL_X0, 0, 1
	eret
1:	b	eret_to_el0
.endm
LOCAL_FUNC elx_irq , :
#if defined(CFG_ARM_GICV3)
	native_intr_handler	irq
#else
	foreign_intr_handler	irq
#endif
END_FUNC elx_irq
LOCAL_FUNC elx_fiq , :
#if defined(CFG_ARM_GICV3)
	foreign_intr_handler	fiq
#else
	native_intr_handler	fiq
#endif
END_FUNC elx_fiq
