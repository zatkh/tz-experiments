#include <arm32_macros.S>
#include <arm.h>
#include <asm.S>
#include <generated/asm-defines.h>
#include <keep.h>
#include <kernel/unwind.h>
#include <sm/optee_smc.h>
#include <sm/teesmc_opteed.h>
#include <sm/teesmc_opteed_macros.h>
#include <util.h>
	.section .text.sm_asm
FUNC sm_save_modes_regs , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	cps	#CPSR_MODE_SYS
	stm	r0!, {sp, lr}
	cps	#CPSR_MODE_IRQ
	mrs	r2, spsr
	stm	r0!, {r2, sp, lr}
	cps	#CPSR_MODE_FIQ
	mrs	r2, spsr
	stm	r0!, {r2, sp, lr}
	cps	#CPSR_MODE_SVC
	mrs	r2, spsr
	stm	r0!, {r2, sp, lr}
	cps	#CPSR_MODE_ABT
	mrs	r2, spsr
	stm	r0!, {r2, sp, lr}
	cps	#CPSR_MODE_UND
	mrs	r2, spsr
	stm	r0!, {r2, sp, lr}
	cps	#CPSR_MODE_MON
	bx	lr
UNWIND(	.fnend)
END_FUNC sm_save_modes_regs
FUNC sm_restore_modes_regs , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	cps	#CPSR_MODE_SYS
	ldm	r0!, {sp, lr}
	cps	#CPSR_MODE_IRQ
	ldm	r0!, {r2, sp, lr}
	msr	spsr_fsxc, r2
	cps	#CPSR_MODE_FIQ
	ldm	r0!, {r2, sp, lr}
	msr	spsr_fsxc, r2
	cps	#CPSR_MODE_SVC
	ldm	r0!, {r2, sp, lr}
	msr	spsr_fsxc, r2
	cps	#CPSR_MODE_ABT
	ldm	r0!, {r2, sp, lr}
	msr	spsr_fsxc, r2
	cps	#CPSR_MODE_UND
	ldm	r0!, {r2, sp, lr}
	msr	spsr_fsxc, r2
	cps	#CPSR_MODE_MON
	bx	lr
UNWIND(	.fnend)
END_FUNC sm_restore_modes_regs
LOCAL_FUNC sm_smc_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	srsdb	sp!, #CPSR_MODE_MON
	push	{r0-r7}
	clrex		
	read_scr r1
	tst	r1, #SCR_NS
	bne	.smc_from_nsec
	sub	sp, sp, #(SM_CTX_SEC + SM_SEC_CTX_R0)
	add	r0, sp, #SM_CTX_SEC
	bl	sm_save_modes_regs
	add	r8, sp, #(SM_CTX_SEC + SM_SEC_CTX_R0)
	ldm	r8, {r0-r4}
	mov_imm	r9, TEESMC_OPTEED_RETURN_FIQ_DONE
	cmp	r0, r9
	addne	r8, sp, #(SM_CTX_NSEC + SM_NSEC_CTX_R0)
	stmne	r8, {r1-r4}
	add	r0, sp, #SM_CTX_NSEC
	bl	sm_restore_modes_regs
.sm_ret_to_nsec:
	add     r0, sp, #(SM_CTX_NSEC + SM_NSEC_CTX_R8)
	ldm	r0, {r8-r12}
	read_scr r0
	orr	r0, r0, #(SCR_NS | SCR_FIQ) 
	write_scr r0
	add	sp, sp, #(SM_CTX_NSEC + SM_NSEC_CTX_R0)
	b	.sm_exit
.smc_from_nsec:
	sub	sp, sp, #(SM_CTX_NSEC + SM_NSEC_CTX_R0)
	bic	r1, r1, #(SCR_NS | SCR_FIQ) 
	write_scr r1
	isb
	add	r0, sp, #(SM_CTX_NSEC + SM_NSEC_CTX_R8)
	stm	r0, {r8-r12}
	mov	r0, sp
	bl	sm_from_nsec
	cmp	r0, #0
	beq	.sm_ret_to_nsec
	add	sp, sp, #(SM_CTX_SEC + SM_SEC_CTX_R0)
.sm_exit:
	pop	{r0-r7}
	rfefd	sp!
UNWIND(	.fnend)
END_FUNC sm_smc_entry
LOCAL_FUNC sm_fiq_entry , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	sub	lr, lr, #4
	srsdb	sp!, #CPSR_MODE_MON
	push	{r0-r7}
	clrex		
	sub	sp, sp, #(SM_CTX_NSEC + SM_NSEC_CTX_R0)
	read_scr r1
	bic	r1, r1, #(SCR_NS | SCR_FIQ) 
	write_scr r1
	isb
	add	r0, sp, #SM_CTX_NSEC
	bl	sm_save_modes_regs
	stm	r0!, {r8-r12}
	ldr	r0, =(thread_vector_table + THREAD_VECTOR_TABLE_FIQ_ENTRY)
	str	r0, [sp, #(SM_CTX_SEC + SM_SEC_CTX_MON_LR)]
	add	r0, sp, #SM_CTX_SEC
	bl	sm_restore_modes_regs
	add	sp, sp, #(SM_CTX_SEC + SM_SEC_CTX_MON_LR)
	rfefd	sp!
UNWIND(	.fnend)
END_FUNC sm_fiq_entry
	.section .text.sm_vect_table
        .align	5
LOCAL_FUNC sm_vect_table , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	b	.		
	b	.		
	b	sm_smc_entry	
	b	.		
	b	.		
	b	.		
	b	.		
	b	sm_fiq_entry	
#ifdef CFG_CORE_WORKAROUND_SPECTRE_BP
	.macro vector_prologue_spectre
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		add	sp, sp, #1	
		nop			
	.endm
	.align 5
sm_vect_table_a15:
	vector_prologue_spectre
	write_iciallu
	isb
	b	1f
	.align 5
sm_vect_table_bpiall:
	vector_prologue_spectre
	write_bpiall
	isb
1:
	tst	sp, #(BIT(0) | BIT(1) | BIT(2))
	beq	sm_fiq_entry
	eor	sp, sp, #(BIT(0) | BIT(2))
	tst	sp, #(BIT(0) | BIT(1) | BIT(2))
	beq	sm_smc_entry
	b	.
#endif 
UNWIND(	.fnend)
END_FUNC sm_vect_table
FUNC sm_init , :
UNWIND(	.fnstart)
	mrs	r1, cpsr
	cps	#CPSR_MODE_MON
	sub	sp, r0, #(SM_CTX_SIZE - SM_CTX_NSEC)
#ifdef CFG_INIT_CNTVOFF
	read_scr r0
	orr	r0, r0, #SCR_NS 
	write_scr r0
	isb
	read_idpfr1 r2
	mov	r3, r2
	ands    r3, r3, #IDPFR1_GENTIMER_MASK
	beq	.no_gentimer
	ands    r2, r2, #IDPFR1_VIRT_MASK
	beq	.no_gentimer
	mov	r2, #0
	write_cntvoff r2, r2
.no_gentimer:
	bic	r0, r0, #SCR_NS 
	write_scr r0
	isb
#endif
	msr	cpsr, r1
#ifdef CFG_CORE_WORKAROUND_SPECTRE_BP
	read_midr r1
	ubfx	r2, r1, #MIDR_IMPLEMENTER_SHIFT, #MIDR_IMPLEMENTER_WIDTH
	cmp	r2, #MIDR_IMPLEMENTER_ARM
	bne	1f
	ubfx	r2, r1, #MIDR_PRIMARY_PART_NUM_SHIFT, \
			#MIDR_PRIMARY_PART_NUM_WIDTH
	movw	r3, #CORTEX_A8_PART_NUM
	cmp	r2, r3
	movwne	r3, #CORTEX_A9_PART_NUM
	cmpne	r2, r3
	movwne	r3, #CORTEX_A17_PART_NUM
	cmpne	r2, r3
	ldreq	r0, =sm_vect_table_bpiall
	beq	2f
	movw	r3, #CORTEX_A15_PART_NUM
	cmp	r2, r3
	ldreq	r0, =sm_vect_table_a15
	beq	2f
#endif
1:	ldr	r0, =sm_vect_table
2:	write_mvbar r0
	bx	lr
END_FUNC sm_init
KEEP_PAGER sm_init
FUNC sm_get_nsec_ctx , :
	mrs	r1, cpsr
	cps	#CPSR_MODE_MON
	mov	r0, sp
	msr	cpsr, r1
	bx	lr
END_FUNC sm_get_nsec_ctx
