#include <asm.S>
#include <kernel/spinlock.h>
#include <kernel/unwind.h>
FUNC __cpu_spin_lock , :
UNWIND(	.fnstart)
	mov r2, #SPINLOCK_LOCK
1:
	ldrex r1, [r0]
	cmp r1, #SPINLOCK_UNLOCK
	wfene
	strexeq r1, r2, [r0]
	cmpeq r1, #0
	bne 1b
	dmb
	bx lr
UNWIND(	.fnend)
END_FUNC __cpu_spin_lock
FUNC __cpu_spin_trylock , :
UNWIND(	.fnstart)
	mov r2, #SPINLOCK_LOCK
	mov r1, r0
1:
	ldrex r0, [r1]
	cmp r0, #0
	bne 1f
	strex r0, r2, [r1]
	cmp r0, #0
	bne 1b
	dmb
	bx lr
1:
	clrex
	dmb
	bx lr
UNWIND(	.fnend)
END_FUNC __cpu_spin_trylock
FUNC __cpu_spin_unlock , :
UNWIND(	.fnstart)
	dmb
	mov r1, #SPINLOCK_UNLOCK
	str r1, [r0]
	dsb
	sev
	bx lr
UNWIND(	.fnend)
END_FUNC __cpu_spin_unlock
