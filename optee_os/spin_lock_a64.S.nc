#include <asm.S>
#include <kernel/spinlock.h>
FUNC __cpu_spin_lock , :
	mov	w2, #SPINLOCK_LOCK
	sevl
l1:	wfe
l2:	ldaxr	w1, [x0]
	cbnz	w1, l1
	stxr	w1, w2, [x0]
	cbnz	w1, l2
	ret
END_FUNC __cpu_spin_lock
FUNC __cpu_spin_trylock , :
	mov     x1, x0
	mov     w2, #SPINLOCK_LOCK
.loop:	ldaxr   w0, [x1]
	cbnz    w0, .cpu_spin_trylock_out
	stxr    w0, w2, [x1]
	cbnz    w0, .loop
.cpu_spin_trylock_out:
	ret
END_FUNC __cpu_spin_trylock
FUNC __cpu_spin_unlock , :
	stlr	wzr, [x0]
	ret
END_FUNC __cpu_spin_unlock
