#include <arm32_macros.S>
#include <arm.h>
#include <asm.S>
#include <keep.h>
#include <kernel/asan.h>
#include <kernel/cache_helpers.h>
#include <kernel/unwind.h>
#include <platform_config.h>
#include <sm/optee_smc.h>
#include <sm/teesmc_opteed.h>
#include <sm/teesmc_opteed_macros.h>
.section .data
.balign 4
#ifdef CFG_BOOT_SYNC_CPU
.equ SEM_CPU_READY, 1
#endif
#ifdef CFG_PL310
.section .rodata.init
panic_boot_file:
	.asciz __FILE__
LOCAL_FUNC __assert_flat_mapped_range , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	push	{ r4-r6, lr }
	mov	r4, r0
	mov	r5, r1
	bl	cpu_mmu_enabled
	cmp	r0, #0
	beq	1f
	mov	r0, r4
	bl	virt_to_phys
	cmp	r0, r4
	beq	1f
	ldr	r0, =panic_boot_file
	mov	r1, r5
	mov	r2, #0
	mov	r3, #0
	bl	__do_panic
	b	.		
1:	pop	{ r4-r6, pc }
UNWIND(	.fnend)
END_FUNC __assert_flat_mapped_range
	.macro assert_flat_mapped_range va, line
		ldr	r0, =(\va)
		ldr	r1, =\line
		bl	__assert_flat_mapped_range
	.endm
#endif 
.weak plat_cpu_reset_early
FUNC plat_cpu_reset_early , :
UNWIND(	.fnstart)
	bx	lr
UNWIND(	.fnend)
END_FUNC plat_cpu_reset_early
KEEP_PAGER plat_cpu_reset_early
	.section .text.reset_vect_table
	.align 5
LOCAL_FUNC reset_vect_table , :
	b	.
	b	.	
	b	.	
	b	.	
	b	.	
	b	.	
	b	.	
	b	.	
END_FUNC reset_vect_table
	.macro cpu_is_ready
#ifdef CFG_BOOT_SYNC_CPU
	bl	__get_core_pos
	lsl	r0, r0, #2
	ldr	r1,=sem_cpu_sync
	ldr	r2, =SEM_CPU_READY
	str	r2, [r1, r0]
	dsb
	sev
#endif
	.endm
	.macro wait_primary
#ifdef CFG_BOOT_SYNC_CPU
	ldr	r0, =sem_cpu_sync
	mov	r2, #SEM_CPU_READY
	sev
1:
	ldr	r1, [r0]
	cmp	r1, r2
	wfene
	bne	1b
#endif
	.endm
	.macro wait_secondary
#ifdef CFG_BOOT_SYNC_CPU
	ldr	r0, =sem_cpu_sync
	mov	r3, #CFG_TEE_CORE_NB_CORE
	mov	r2, #SEM_CPU_READY
	sev
1:
	subs	r3, r3, #1
	beq	3f
	add	r0, r0, #4
2:
	ldr	r1, [r0]
	cmp	r1, r2
	wfene
	bne	2b
	b	1b
3:
#endif
	.endm
	.macro set_sctlr
		read_sctlr r0
		bic	r0, r0, #(SCTLR_M | SCTLR_C)
		bic	r0, r0, #SCTLR_I
		bic	r0, r0, #SCTLR_TE
#if defined(CFG_SCTLR_ALIGNMENT_CHECK)
		orr	r0, r0, #SCTLR_A
#else
		bic	r0, r0, #SCTLR_A
#endif
#if defined(CFG_HWSUPP_MEM_PERM_WXN) && defined(CFG_CORE_RWDATA_NOEXEC)
		orr	r0, r0, #(SCTLR_WXN | SCTLR_UWXN)
#endif
#if defined(CFG_ENABLE_SCTLR_RR)
		orr	r0, r0, #SCTLR_RR
#endif
		write_sctlr r0
	.endm
	.macro enable_branch_prediction
#if defined(CFG_ENABLE_SCTLR_Z)
		read_sctlr r0
		write_bpiall
		dsb
		isb
		orr	r0, r0, #SCTLR_Z
		write_sctlr r0
#endif
	.endm
	.macro bootargs_entry
#if defined(CFG_NS_ENTRY_ADDR)
	ldr	r5, =CFG_NS_ENTRY_ADDR
#else
	mov	r5, lr
#endif
#if defined(CFG_PAGEABLE_ADDR)
	ldr	r4, =CFG_PAGEABLE_ADDR
#else
	mov	r4, r0
#endif
#if defined(CFG_DT_ADDR)
	ldr	r6, =CFG_DT_ADDR
#else
	mov	r6, r2
#endif
	mov	r7, r1
	.endm
	.macro maybe_init_spectre_workaround
#if !defined(CFG_WITH_ARM_TRUSTED_FW) && \
    (defined(CFG_CORE_WORKAROUND_SPECTRE_BP) || \
     defined(CFG_CORE_WORKAROUND_SPECTRE_BP_SEC))
	read_midr r0
	ubfx	r1, r0, #MIDR_IMPLEMENTER_SHIFT, #MIDR_IMPLEMENTER_WIDTH
	cmp	r1, #MIDR_IMPLEMENTER_ARM
	bne	1f
	ubfx	r1, r0, #MIDR_PRIMARY_PART_NUM_SHIFT, \
			#MIDR_PRIMARY_PART_NUM_WIDTH
	movw	r2, #CORTEX_A8_PART_NUM
	cmp	r1, r2
	moveq	r2, #ACTLR_CA8_ENABLE_INVALIDATE_BTB
	beq	2f
	movw	r2, #CORTEX_A15_PART_NUM
	cmp	r1, r2
	moveq	r2, #ACTLR_CA15_ENABLE_INVALIDATE_BTB
	bne	1f	
2:
	read_actlr r0
	orr	r0, r0, r2
	write_actlr r0
	isb
1:
#endif
	.endm
FUNC _start , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	bootargs_entry
	cps	#CPSR_MODE_SVC
	bl	plat_cpu_reset_early
	maybe_init_spectre_workaround
	set_sctlr
	isb
	ldr	r0, =reset_vect_table
	write_vbar r0
#if defined(CFG_WITH_ARM_TRUSTED_FW)
	b	reset_primary
#else
	bl	__get_core_pos
	cmp	r0, #0
	beq	reset_primary
	b	reset_secondary
#endif
UNWIND(	.fnend)
END_FUNC _start
KEEP_INIT _start
	.macro set_sp
		bl	__get_core_pos
		cmp	r0, #CFG_TEE_CORE_NB_CORE
		bge	unhandled_cpu
		ldr	r1, =stack_tmp_stride
		ldr	r1, [r1]
		mul	r1, r0, r1
		ldr	r0, =stack_tmp_export
		ldr	r0, [r0]
		add	sp, r1, r0
	.endm
	.macro __inval_cache_vrange vbase, vend, line
#if defined(CFG_PL310) && !defined(CFG_PL310_SIP_PROTOCOL)
		assert_flat_mapped_range (\vbase), (\line)
		bl	pl310_base
		ldr	r1, =(\vbase)
		ldr	r2, =(\vend)
		bl	arm_cl2_invbypa
#endif
		ldr	r0, =(\vbase)
		ldr	r1, =(\vend)
		sub	r1, r1, r0
		bl	dcache_inv_range
	.endm
	.macro __flush_cache_vrange vbase, vend, line
#if defined(CFG_PL310) && !defined(CFG_PL310_SIP_PROTOCOL)
		assert_flat_mapped_range (\vbase), (\line)
		ldr	r0, =(\vbase)
		ldr	r1, =(\vend)
		sub	r1, r1, r0
		bl	dcache_clean_range
		bl	pl310_base
		ldr	r1, =(\vbase)
		ldr	r2, =(\vend)
		bl	arm_cl2_cleaninvbypa
#endif
		ldr	r0, =(\vbase)
		ldr	r1, =(\vend)
		sub	r1, r1, r0
		bl	dcache_cleaninv_range
	.endm
#define inval_cache_vrange(vbase, vend) \
		__inval_cache_vrange (vbase), ((vend) - 1), __LINE__
#define flush_cache_vrange(vbase, vend) \
		__flush_cache_vrange (vbase), ((vend) - 1), __LINE__
#ifdef CFG_BOOT_SYNC_CPU
#define flush_cpu_semaphores \
		flush_cache_vrange(sem_cpu_sync, \
				   (sem_cpu_sync + (CFG_TEE_CORE_NB_CORE << 2)))
#else
#define flush_cpu_semaphores
#endif
LOCAL_FUNC reset_primary , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
#ifdef CFG_WITH_PAGER
	ldr	r0, =__init_start	
	ldr	r1, =__data_end 	
	ldr	r2, =__tmp_hashes_end	
	sub	r2, r2, r0		
	add	r0, r0, r2
	add	r1, r1, r2
	ldr	r2, =__init_start
copy_init:
	ldmdb	r1!, {r3, r8-r12, sp}
	stmdb	r0!, {r3, r8-r12, sp}
	cmp	r0, r2
	bgt	copy_init
#endif
	ldr	r0, =__bss_start
	ldr	r1, =__bss_end
	mov	r2, #0
	mov	r3, #0
clear_bss:
	stmia	r0!, {r2, r3}
	cmp	r0, r1
	bls	clear_bss
#ifdef CFG_CORE_SANITIZE_KADDRESS
	ldr	r0, =__asan_shadow_start	
	ldr	r1, =__asan_shadow_end	
	mov	r2, #ASAN_DATA_RED_ZONE
shadow_no_access:
	str	r2, [r0], #4
	cmp	r0, r1
	bls	shadow_no_access
	ldr	r2, =CFG_ASAN_SHADOW_OFFSET
	ldr	r0, =__nozi_stack_start	
	lsr	r0, r0, #ASAN_BLOCK_SHIFT
	add	r0, r0, r2
	ldr	r1, =__nozi_stack_end	
	lsr	r1, r1, #ASAN_BLOCK_SHIFT
	add	r1, r1, r2
	mov	r2, #0
shadow_stack_access_ok:
	strb	r2, [r0], #1
	cmp	r0, r1
	bls	shadow_stack_access_ok
#endif
	set_sp
	bl	plat_cpu_reset_late
	bl	console_init
#ifdef CFG_PL310
	bl	pl310_base
	bl	arm_cl2_config
#endif
#ifdef CFG_WITH_PAGER
	inval_cache_vrange(__text_start, __tmp_hashes_end)
#else
	inval_cache_vrange(__text_start, __end)
#endif
#if defined(CFG_PL310) && !defined(CFG_PL310_SIP_PROTOCOL)
	bl	pl310_base
	bl	arm_cl2_enable
#endif
	bl	core_init_mmu_map
	bl	core_init_mmu_regs
	bl	cpu_mmu_enable
	bl	cpu_mmu_enable_icache
	bl	cpu_mmu_enable_dcache
	enable_branch_prediction
	mov	r0, r4		
	mov	r1, r5		
	mov	r2, r6		
	bl	generic_boot_init_primary
	mov	r4, r0		
#ifdef CFG_WITH_PAGER
	flush_cache_vrange(__text_start, __init_end)
#else
	flush_cache_vrange(__text_start, __end)
#endif
	cpu_is_ready
	flush_cpu_semaphores
	wait_secondary
#ifdef CFG_PL310_LOCKED
#ifdef CFG_PL310_SIP_PROTOCOL
#error "CFG_PL310_LOCKED must not be defined when CFG_PL310_SIP_PROTOCOL=y"
#endif
	bl	pl310_base
	bl	arm_cl2_lockallways
	bl	pl310_base
	bl	arm_cl2_cleaninvbyway
#endif
	bl 	thread_clr_boot_thread
#if defined(CFG_WITH_ARM_TRUSTED_FW)
	mov	r1, r4
#else
	mov	r4, #0
	mov	r3, r6		
	mov	r2, r7		
	mov	r1, #0
#endif 
	mov	r0, #TEESMC_OPTEED_RETURN_ENTRY_DONE
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC reset_primary
LOCAL_FUNC unhandled_cpu , :
UNWIND(	.fnstart)
	wfi
	b	unhandled_cpu
UNWIND(	.fnend)
END_FUNC unhandled_cpu
#if defined(CFG_WITH_ARM_TRUSTED_FW)
FUNC cpu_on_handler , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	mov	r4, r0
	mov	r5, r1
	mov	r6, lr
	set_sctlr
	isb
	ldr	r0, =reset_vect_table
	write_vbar r0
	mov	r4, lr
	set_sp
	bl	core_init_mmu_regs
	bl	cpu_mmu_enable
	bl	cpu_mmu_enable_icache
	bl	cpu_mmu_enable_dcache
	enable_branch_prediction
	mov	r0, r4
	mov	r1, r5
	bl	generic_boot_cpu_on_handler
	bx	r6
UNWIND(	.fnend)
END_FUNC cpu_on_handler
KEEP_PAGER cpu_on_handler
#else 
LOCAL_FUNC reset_secondary , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	ldr	r0, =reset_vect_table
	write_vbar r0
	wait_primary
	set_sp
	bl	plat_cpu_reset_late
#if defined (CFG_BOOT_SECONDARY_REQUEST)
	mov	r0, #DCACHE_OP_INV
	bl	dcache_op_level1
#endif
	bl	core_init_mmu_regs
	bl	cpu_mmu_enable
	bl	cpu_mmu_enable_icache
	bl	cpu_mmu_enable_dcache
	enable_branch_prediction
	cpu_is_ready
#if defined (CFG_BOOT_SECONDARY_REQUEST)
	bl	generic_boot_core_hpen
	ldm	r0, {r0, r6}
#else
	mov	r0, r5		
	mov	r6, #0
#endif
	bl	generic_boot_init_secondary
	mov	r0, #TEESMC_OPTEED_RETURN_ENTRY_DONE
	mov	r1, r6
	mov	r2, #0
	mov	r3, #0
	mov	r4, #0
	smc	#0
	b	.	
UNWIND(	.fnend)
END_FUNC reset_secondary
KEEP_PAGER reset_secondary
#endif 
