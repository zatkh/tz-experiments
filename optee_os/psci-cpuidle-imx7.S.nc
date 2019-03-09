#include <kernel/unwind.h>
#include <asm.S>
#include <arm.h>
#include <arm32_macros.S>
#include <generated/imx_pm_asm_defines.h>
#include <imx-regs.h>
#include <platform_config.h>
#include <kernel/cache_helpers.h>
#include <kernel/tz_ssvce_def.h>
#include <kernel/tz_proc_def.h>
#define MX7_SRC_GPR1	0x74
#define MX7_SRC_GPR2	0x78
#define MX7_SRC_GPR3	0x7c
#define MX7_SRC_GPR4	0x80
#define MX7_GPC_IMR1	0x30
#define MX7_GPC_IMR2	0x34
#define MX7_GPC_IMR3	0x38
#define MX7_GPC_IMR4	0x3c
#define DDRC_STAT	0x4
#define DDRC_PWRCTL	0x30
#define DDRC_DBG1	0x304
#define DDRC_DBGCAM	0x308
#define DDRC_PSTAT	0x3fc
#define DDRC_PCTRL_0	0x490
	.section .text.psci.cpuidle
	.align 3
	.macro	imx_pen_lock
	mov	r8, r0
	read_mpidr r5
	and	r5, r5, #3
	add	r6, r8, #PM_INFO_MX7_VAL_OFF
	cmp	r5, #0
	addeq	r7, r8, #PM_INFO_MX7_FLAG0_OFF
	addeq	r8, r8, #PM_INFO_MX7_FLAG1_OFF
	addne	r7, r8, #PM_INFO_MX7_FLAG1_OFF
	addne	r8, r8, #PM_INFO_MX7_FLAG0_OFF
	mov	r9, #1
	str	r9, [r7]
	dsb
	str	r5, [r6]
1:
	dsb
	ldr	r9, [r8]
	cmp	r9, #1
	ldreq	r9, [r6]
	cmpeq	r9, r5
	beq	1b
	.endm
	.macro	imx_pen_unlock
	dsb
	read_mpidr r6
	and	r6, r6, #3
	cmp	r6, #0
	addeq	r7, r0, #PM_INFO_MX7_FLAG0_OFF
	addne	r7, r0, #PM_INFO_MX7_FLAG1_OFF
	mov	r9, #0
	str	r9, [r7]
	.endm
	.macro  disable_l1_dcache
	push	{r0 - r12, lr}
	mov	r0, #DCACHE_OP_CLEAN_INV
	ldr	r1, =dcache_op_all
	blx	r1
	pop	{r0 - r12, lr}
	read_sctlr r7
	bic	r7, r7, #SCTLR_C
	write_sctlr r7
	dsb
	isb
	push	{r0 - r12, lr}
	mov	r0, #DCACHE_OP_CLEAN_INV
	ldr	r1, =dcache_op_all
	blx	r1
	pop	{r0 - r12, lr}
	clrex
	read_actlr r8
	bic	r8, r8, #ACTLR_SMP
	write_actlr r8
	isb
	dsb
	.endm
	.macro	tlb_set_to_ocram
	read_ttbr1 r7
	str	r7, [r0, #PM_INFO_MX7_TTBR1_OFF]
	read_ttbr0 r7
	str	r7, [r0, #PM_INFO_MX7_TTBR0_OFF]
	read_sctlr r6
	bic	r6, r6, #SCTLR_Z
	write_sctlr r6
	write_bpiallis
	ldr	r6, =iram_tbl_phys_addr
	ldr	r7, [r6]
	dsb
	isb
	write_ttbr1 r7
	write_ttbr0 r7
	read_ttbcr r6
	orr	r6, r6, #TTBCR_PD0
	write_ttbcr r6
	dsb
	isb
	write_tlbiallis
	isb
	.endm
	.macro	tlb_back_to_ddr
	read_ttbcr r6
	bic	r6, r6, #TTBCR_PD0
	write_ttbcr r6
	dsb
	isb
	write_tlbiallis
	read_sctlr r6
	orr	r6, r6, #SCTLR_Z
	write_sctlr r6
	write_bpiallis
	ldr	r7, [r0, #PM_INFO_MX7_TTBR1_OFF]
	write_ttbr1 r7
	ldr	r7, [r0, #PM_INFO_MX7_TTBR0_OFF]
	write_ttbr0 r7
	.endm
	.macro ddrc_enter_self_refresh
	ldr	r10, [r0, #PM_INFO_MX7_DDRC_V_OFF]
	ldr	r7, =0x0
	str	r7, [r10, #DDRC_PCTRL_0]
	ldr	r7, =0x0
	str	r7, [r10, #DDRC_PWRCTL]
	ldr	r6, =(0x1 << 16)
	orr	r6, r6, #0x1
2:
	ldr	r7, [r10, #DDRC_PSTAT]
	ands	r7, r7, r6
	bne	2b
	ldr	r7, =0x1
	str	r7, [r10, #DDRC_DBG1]
	ldr	r6, =0x36000000
11:
	ldr	r7, [r10, #DDRC_DBGCAM]
	and	r7, r7, r6
	cmp	r7, r6
	bne	11b
	ldr	r7, =(0x1 << 5)
	str	r7, [r10, #DDRC_PWRCTL]
3:
	ldr	r7, [r10, #DDRC_STAT]
	and	r7, r7, #0x3
	cmp	r7, #0x3
	bne	3b
4:
	ldr	r7, [r10, #DDRC_STAT]
	ands	r7, r7, #0x20
	beq	4b
	ldr	r7, [r10, #DDRC_PWRCTL]
	orr	r7, r7, #(1 << 3)
	str	r7, [r10, #DDRC_PWRCTL]
	ldr	r10, [r0, #PM_INFO_MX7_IOMUXC_GPR_V_OFF]
	ldr	r7, =0xf0000
	str	r7, [r10]
	ldr	r7, =20
12:
	subs	r7, r7, #0x1
	bne	12b
	.endm
	.macro ddrc_exit_self_refresh
	cmp	r5, #0x1
	ldreq	r10, [r0, #PM_INFO_MX7_IOMUXC_GPR_P_OFF]
	ldrne	r10, [r0, #PM_INFO_MX7_IOMUXC_GPR_V_OFF]
	ldr	r7, =0x0
	str	r7, [r10]
	ldr	r7, =20
13:
	subs	r7, r7, #0x1
	bne	13b
	cmp	r5, #0x1
	ldreq	r10, [r0, #PM_INFO_MX7_DDRC_P_OFF]
	ldrne	r10, [r0, #PM_INFO_MX7_DDRC_V_OFF]
	ldr	r7, =0x0
	str	r7, [r10, #DDRC_DBG1]
	ldr	r6, =0x30000000
14:
	ldr	r7, [r10, #DDRC_DBGCAM]
	and	r7, r7, r6
	cmp	r7, r6
	bne	14b
	ldr	r7, =0x0
	str	r7, [r10, #DDRC_PWRCTL]
5:
	ldr	r7, [r10, #DDRC_STAT]
	and	r7, r7, #0x3
	cmp	r7, #0x3
	beq	5b
	ldr	r7, [r10, #DDRC_PWRCTL]
	orr	r7, r7, #(1 << 0)
	str	r7, [r10, #DDRC_PWRCTL]
	ldr	r7, =0x1
	str	r7, [r10, #DDRC_PCTRL_0]
	.endm
	.macro	pll_do_wait_lock
6:
	ldr	r7, [r10, r8]
	ands	r7, #0x80000000
	beq	6b
	.endm
	.macro ccm_enter_idle
	ldr	r10, [r0, #PM_INFO_MX7_ANATOP_V_OFF]
	ldr	r7, =0x8000
	str	r7, [r10, #0xc8]
	ldr	r10, [r0, #PM_INFO_MX7_CCM_V_OFF]
	ldr	r8, =0x8000
	ldr	r7, [r10, r8]
	bic	r7, r7, #0x7000000
	str	r7, [r10, r8]
	ldr	r8, =0x8800
	ldr	r7, [r10, r8]
	orr	r7, r7, #0x7
	str	r7, [r10, r8]
	ldr	r8, =0x9000
	ldr	r7, [r10, r8]
	orr	r7, r7, #0x7
	str	r7, [r10, r8]
	ldr	r8, =0x9880
	ldr	r7, [r10, r8]
	bic	r7, r7, #0x10000000
	str	r7, [r10, r8]
	ldr	r10, [r0, #PM_INFO_MX7_ANATOP_V_OFF]
	ldr	r7, =0x8000
	str	r7, [r10, #0xc4]
	ldr	r7, =0x10
	str	r7, [r10, #0xb4]
	ldr	r7, =0x1000
	str	r7, [r10, #0x64]
	str	r7, [r10, #0xb4]
	ldr	r7, =0x100000
	str	r7, [r10, #0x74]
	.endm
	.macro ccm_exit_idle
	cmp	r5, #0x1
	ldreq	r10, [r0, #PM_INFO_MX7_ANATOP_P_OFF]
	ldrne	r10, [r0, #PM_INFO_MX7_ANATOP_V_OFF]
	ldr	r7, =0x1000
	str	r7, [r10, #0x68]
	ldr	r8, =0x60
	pll_do_wait_lock
	ldr	r7, =0x1000
	str	r7, [r10, #0xb8]
	ldr	r8, =0xb0
	pll_do_wait_lock
	ldr	r7, =0x100000
	str	r7, [r10, #0x78]
	ldr	r8, =0x70
	pll_do_wait_lock
	ldr	r7, =0x8000
	str	r7, [r10, #0xc8]
	ldr	r7, =0x10
	str	r7, [r10, #0xb8]
	cmp	r5, #0x1
	ldreq	r10, [r0, #PM_INFO_MX7_CCM_P_OFF]
	ldrne	r10, [r0, #PM_INFO_MX7_CCM_V_OFF]
	ldr	r8, =0x8000
	ldr	r7, [r10, r8]
	orr	r7, r7, #0x1000000
	str	r7, [r10, r8]
	ldr	r8, =0x8800
	ldr	r7, [r10, r8]
	bic	r7, r7, #0x7
	str	r7, [r10, r8]
	ldr	r8, =0x9000
	ldr	r7, [r10, r8]
	bic	r7, r7, #0x7
	str	r7, [r10, r8]
	ldr	r8, =0x9880
	ldr	r7, [r10, r8]
	orr	r7, r7, #0x10000000
	str	r7, [r10, r8]
	cmp	r5, #0x1
	ldreq	r10, [r0, #PM_INFO_MX7_ANATOP_P_OFF]
	ldrne	r10, [r0, #PM_INFO_MX7_ANATOP_V_OFF]
	ldr	r7, =0x8000
	str	r7, [r10, #0xc4]
	.endm
	.macro anatop_enter_idle
	ldr	r10, [r0, #PM_INFO_MX7_ANATOP_V_OFF]
	ldr	r7, [r10]
	orr	r7, r7, #0x1000
	str	r7, [r10]
	ldr	r7, [r10]
	orr	r7, r7, #0x1
	str	r7, [r10]
	ldr	r7, [r10, #0x200]
	orr	r7, r7, #0x40000
	str	r7, [r10, #0x200]
	ldr	r7, [r10, #0x200]
	bic	r7, r7, #0x1
	str	r7, [r10, #0x200]
	ldr	r7, [r10, #0x210]
	bic	r7, r7, #0x1
	str	r7, [r10, #0x210]
	ldr	r7, [r10, #0x220]
	bic	r7, r7, #0x1
	str	r7, [r10, #0x220]
	ldr	r7, [r10, #0x270]
	orr	r7, r7, #0x400
	str	r7, [r10, #0x270]
	orr	r7, r7, #0x1
	str	r7, [r10, #0x270]
	.endm
	.macro anatop_exit_idle
	cmp	r5, #0x1
	ldreq	r10, [r0, #PM_INFO_MX7_ANATOP_P_OFF]
	ldrne	r10, [r0, #PM_INFO_MX7_ANATOP_V_OFF]
	ldr	r7, [r10, #0x270]
	bic	r7, r7, #0x1
	str	r7, [r10, #0x270]
	bic	r7, r7, #0x400
	str	r7, [r10, #0x270]
	ldr	r7, [r10, #0x220]
	orr	r7, r7, #0x1
	str	r7, [r10, #0x220]
7:
	ldr	r7, [r10, #0x220]
	ands	r7, #0x20000
	beq	7b
	ldr	r7, [r10, #0x210]
	orr	r7, r7, #0x1
	str	r7, [r10, #0x210]
8:
	ldr	r7, [r10, #0x210]
	ands	r7, #0x20000
	beq	8b
	ldr	r7, [r10, #0x200]
	orr	r7, r7, #0x1
	str	r7, [r10, #0x200]
9:
	ldr	r7, [r10, #0x200]
	ands	r7, #0x20000
	beq	9b
	ldr	r7, [r10, #0x200]
	bic	r7, r7, #0x40000
	str	r7, [r10, #0x200]
	ldr	r7, [r10]
	bic	r7, r7, #0x1
	str	r7, [r10]
10:
	ldr	r7, [r10]
	ands	r7, r7, #0x4
	beq	10b
	ldr	r7, [r10]
	bic	r7, r7, #0x1000
	str	r7, [r10]
	.endm
.extern iram_tlb_phys_addr
FUNC imx7d_low_power_idle, :
UNWIND( .fnstart)
	push	{r0 - r12}
	ldr	r1, [r0, #PM_INFO_MX7_PBASE_OFF]
	ldr	r2, [r0, #PM_INFO_MX7_SIZE_OFF]
	ldr	r5, =imx7d_low_power_idle
	ldr     r6, =wakeup
	sub	r6, r6, r5
	add     r8, r1, r2
	add	r3, r8, r6
	read_mpidr r11
	and	r11, r11, #3
	cmp	r11, #0x0
	ldreq	r6, =MX7_SRC_GPR1
	ldreq	r7, =MX7_SRC_GPR2
	ldrne	r6, =MX7_SRC_GPR3
	ldrne	r7, =MX7_SRC_GPR4
	ldr	r10, [r0, #PM_INFO_MX7_SRC_V_OFF]
	str	r3, [r10, r6]
	str	r1, [r10, r7]
	disable_l1_dcache
	tlb_set_to_ocram
	ldr	r6, [r0, #PM_INFO_MX7_NUM_ONLINE_CPUS_OFF]
	ldr	r7, [r0, #PM_INFO_MX7_NUM_LPI_CPUS_OFF]
	cmp	r6, r7
	bne	lpi_enter_done
	ddrc_enter_self_refresh
	ccm_enter_idle
	anatop_enter_idle
	ldr	r10, [r0, #PM_INFO_MX7_GIC_DIST_V_OFF]
	ldr	r7, =0x0
	ldr	r8, =0x1000
	str	r7, [r10, r8]
	ldr	r10, [r0, #PM_INFO_MX7_GPC_V_OFF]
	ldr	r4, [r10, #MX7_GPC_IMR1]
	ldr	r5, [r10, #MX7_GPC_IMR2]
	ldr	r6, [r10, #MX7_GPC_IMR3]
	ldr	r7, [r10, #MX7_GPC_IMR4]
	ldr	r8, =0xffffffff
	str	r8, [r10, #MX7_GPC_IMR1]
	str	r8, [r10, #MX7_GPC_IMR2]
	str	r8, [r10, #MX7_GPC_IMR3]
	str	r8, [r10, #MX7_GPC_IMR4]
	ldr	r8, [r10, #0x14]
	bic	r8, r8, #(0x3f << 24)
	orr	r8, r8, #(0x8 << 24)
	str	r8, [r10, #0x14]
	ldr	r8, [r10, #0x14]
	orr	r8, r8, #(0x1 << 30)
	str	r8, [r10, #0x14]
	str	r4, [r10, #MX7_GPC_IMR1]
	str	r5, [r10, #MX7_GPC_IMR2]
	str	r6, [r10, #MX7_GPC_IMR3]
	str	r7, [r10, #MX7_GPC_IMR4]
	ldr	r4, =5
rbc_loop:
	subs	r4, r4, #0x1
	bne	rbc_loop
lpi_enter_done:
	imx_pen_unlock
        wfi
	isb
	imx_pen_lock
	ldr	r6, [r0, #PM_INFO_MX7_NUM_ONLINE_CPUS_OFF]
	ldr	r7, [r0, #PM_INFO_MX7_NUM_LPI_CPUS_OFF]
	cmp	r6, r7
	bne	skip_lpi_flow
	ldr	r5, =0x0
	anatop_exit_idle
	ccm_exit_idle
	ddrc_exit_self_refresh
	ldr	r10, [r0, #PM_INFO_MX7_GIC_DIST_V_OFF]
	ldr	r7, =0x3
	ldr	r8, =0x1000
	str	r7, [r10, r8]
skip_lpi_flow:
	tlb_back_to_ddr
	read_actlr r7
	orr	r7, r7, #ACTLR_SMP
	write_actlr r7
	isb
	read_sctlr r7
	orr	r7, r7, #SCTLR_C
	write_sctlr r7
	dsb
	isb
	pop	{r0 - r12}
	bx	lr
wakeup:
	write_iciallu
	write_bpiall
	mov	r1, #(SCTLR_I | SCTLR_Z)
	write_sctlr r1
	isb
	cps	#CPSR_MODE_MON
	imx_pen_lock
	ldr	r6, [r0, #PM_INFO_MX7_NUM_ONLINE_CPUS_OFF]
	ldr	r7, [r0, #PM_INFO_MX7_NUM_LPI_CPUS_OFF]
	cmp	r6, r7
	bne	wakeup_skip_lpi_flow
	ldr	r5, =0x1
	anatop_exit_idle
	ccm_exit_idle
	ddrc_exit_self_refresh
wakeup_skip_lpi_flow:
	ldr	lr, [r0, #PM_INFO_MX7_RESUME_ADDR_OFF]
	bx	lr
UNWIND( .fnend)
END_FUNC imx7d_low_power_idle
FUNC v7_cpu_resume, :
UNWIND( .fnstart)
	mov     r0, #0	@ ; write the cache size selection register to be
	write_csselr r0	@ ; sure we address the data cache
	isb		@ ; isb to sync the change to the cachesizeid reg
_inv_dcache_off:
	mov     r0, #0	@ ; set way number to 0
_inv_nextway:
	mov     r1, #0	@ ; set line number (=index) to 0
_inv_nextline:
	orr     r2, r0, r1	@ ; construct way/index value
	write_dcisw r2 @ ; invalidate data or unified cache line by set/way
	add     r1, r1, #1 << LINE_FIELD_OFFSET	@ ; increment the index
	cmp     r1, #1 << LINE_FIELD_OVERFLOW	@ ; overflow out of set field
	bne     _inv_nextline
	add     r0, r0, #1 << WAY_FIELD_OFFSET	@ ; increment the way number
	cmp     r0, #0				@ ; overflow out of way field
	bne     _inv_nextway
	dsb					@ ; synchronise
	blx plat_cpu_reset_early
	b	sm_pm_cpu_resume
UNWIND( .fnend)
END_FUNC v7_cpu_resume
