#include <asm.S>
#include <kernel/tz_proc_def.h>
#include <kernel/tz_ssvce_def.h>
#include <kernel/unwind.h>
#include <platform_config.h>
#define PL310_LOCKDOWN_NBREGS	8
#define PL310_LOCKDOWN_SZREG	4
#define PL310_8WAYS_MASK	0x00FF
#define PL310_16WAYS_UPPERMASK	0xFF00
FUNC arm_cl2_lockallways , :
UNWIND(	.fnstart)
	add	r1, r0, #PL310_DCACHE_LOCKDOWN_BASE
	ldr	r2, [r0, #PL310_AUX_CTRL]
	tst	r2, #PL310_AUX_16WAY_BIT
	mov	r2, #PL310_8WAYS_MASK
	orrne	r2, #PL310_16WAYS_UPPERMASK
	mov	r0, #PL310_LOCKDOWN_NBREGS
1:	
	str	r2, [r1], #PL310_LOCKDOWN_SZREG
	str	r2, [r1], #PL310_LOCKDOWN_SZREG
	subs	r0, r0, #1
	bne	1b
	mov	pc, lr
UNWIND(	.fnend)
END_FUNC arm_cl2_lockallways
.macro syncbyway_set_mask reg
	ldr	\reg, [r0, #PL310_AUX_CTRL]
	tst	\reg, #PL310_AUX_16WAY_BIT
	mov	\reg, #PL310_8WAYS_MASK
	orrne	\reg, \reg, #PL310_16WAYS_UPPERMASK
.endm
FUNC arm_cl2_cleaninvbyway , :
UNWIND(	.fnstart)
	syncbyway_set_mask r1
	str	r1, [r0, #PL310_FLUSH_BY_WAY]
loop_cli_way_done:
	ldr	r2, [r0, #PL310_FLUSH_BY_WAY]
	and	r2, r2, r1
	cmp	r2, #0
	bne	loop_cli_way_done
loop_cli_sync:
	ldr	r1, [r0, #PL310_SYNC]
	cmp	r1, #0
	bne	loop_cli_sync
	mov	r1, #0
	str	r1, [r0, #PL310_SYNC]
loop_cli_sync_done:
	ldr	r1, [r0, #PL310_SYNC]
	cmp	r1, #0
	bne	loop_cli_sync_done
	mov	pc, lr
UNWIND(	.fnend)
END_FUNC arm_cl2_cleaninvbyway
FUNC arm_cl2_invbyway , :
UNWIND(	.fnstart)
	syncbyway_set_mask r1
	str	r1, [r0, #PL310_INV_BY_WAY]
loop_inv_way_done:
	ldr	r2, [r0, #PL310_INV_BY_WAY]
	and	r2, r2, r1
	cmp	r2, #0
	bne	loop_inv_way_done
loop_inv_way_sync:
	ldr	r1, [r0, #PL310_SYNC]
	cmp	r1, #0
	bne	loop_inv_way_sync
	mov	r1, #0
	str	r1, [r0, #PL310_SYNC]
loop_inv_way_sync_done:
	ldr	r1, [r0, #PL310_SYNC]
	cmp	r1, #0
	bne	loop_inv_way_sync_done
	mov	pc, lr
UNWIND(	.fnend)
END_FUNC arm_cl2_invbyway
FUNC arm_cl2_cleanbyway , :
UNWIND(	.fnstart)
	syncbyway_set_mask r1
	str	r1, [r0, #PL310_CLEAN_BY_WAY]
loop_cl_way_done:
	ldr	r2, [r0, #PL310_CLEAN_BY_WAY]
	and	r2, r2, r1
	cmp	r2, #0
	bne	loop_cl_way_done
loop_cl_way_sync:
	ldr	r1, [r0, #PL310_SYNC]
	cmp	r1, #0
	bne	loop_cl_way_sync
	mov	r1, #0
	str	r1, [r0, #PL310_SYNC]
loop_cl_way_sync_done:
	ldr	r1, [r0, #PL310_SYNC]
	cmp	r1, #0
	bne	loop_cl_way_sync_done
	mov	pc, lr
UNWIND(	.fnend)
END_FUNC arm_cl2_cleanbyway
LOCAL_FUNC _arm_cl2_xxxbypa , :
UNWIND(	.fnstart)
	and	r1, #(~(PL310_LINE_SIZE - 1))
#ifdef SCU_BASE
	sub	r0, r0, #(PL310_BASE - SCU_BASE)
	mov	r12, #1
	str	r12, [r0, #SCU_ERRATA744369]
	dsb
	add	r0, r0, #(PL310_BASE - SCU_BASE)
#endif
loop_cl2_xxxbypa:
	str	r1, [r0, r3]
loop_xxx_pa_done:
	ldr	r12, [r0, r3]
	and	r12, r12, r1
	cmp	r12, #0
	bne	loop_xxx_pa_done
	add	r1, r1, #PL310_LINE_SIZE
	cmp	r2, r1
	bpl	loop_cl2_xxxbypa
loop_xxx_pa_sync:
	ldr	r12, [r0, #PL310_SYNC]
	cmp	r12, #0
	bne	loop_xxx_pa_sync
	mov	r12, #0
	str	r12, [r0, #PL310_SYNC]
loop_xxx_pa_sync_done:
	ldr	r12, [r0, #PL310_SYNC]
	cmp	r12, #0
	bne	loop_xxx_pa_sync_done
	mov	pc, lr
UNWIND(	.fnend)
END_FUNC _arm_cl2_xxxbypa
FUNC arm_cl2_cleanbypa , :
UNWIND(	.fnstart)
	mov	r3, #PL310_CLEAN_BY_PA
	b	_arm_cl2_xxxbypa
UNWIND(	.fnend)
END_FUNC arm_cl2_cleanbypa
FUNC arm_cl2_invbypa , :
UNWIND(	.fnstart)
	mov	r3, #PL310_INV_BY_PA
	b	_arm_cl2_xxxbypa
UNWIND(	.fnend)
END_FUNC arm_cl2_invbypa
FUNC arm_cl2_cleaninvbypa , :
UNWIND(	.fnstart)
	mov	r3, #PL310_FLUSH_BY_PA
	b	_arm_cl2_xxxbypa
UNWIND(	.fnend)
END_FUNC arm_cl2_cleaninvbypa
