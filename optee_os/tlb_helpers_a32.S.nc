#include <arm32_macros.S>
#include <asm.S>
#include <kernel/unwind.h>
	.section .text.ssvce
FUNC tlbi_all , :
UNWIND(	.fnstart)
	dsb	ishst		
	write_tlbiallis 	
	dsb	ish		
	isb			
	bx	lr
UNWIND(	.fnend)
END_FUNC tlbi_all
FUNC tlbi_mva_allasid , :
UNWIND(	.fnstart)
	dsb	ishst		
	write_tlbimvaais r0	
	dsb	ish		
	isb			
	bx	lr
UNWIND(	.fnend)
END_FUNC tlbi_mva_allasid
FUNC tlbi_asid , :
UNWIND(	.fnstart)
	dsb	ishst		
	write_tlbiasidis r0	
	orr	r0, r0, #1	
	write_tlbiasidis r0	
	dsb	ish		
	isb			
	bx	lr
UNWIND(	.fnend)
END_FUNC tlbi_asid
