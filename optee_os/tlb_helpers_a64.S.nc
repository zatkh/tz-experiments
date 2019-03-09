#include <arm64.h>
#include <asm.S>
#include <util.h>
FUNC tlbi_all , :
	dsb	ishst		
	tlbi	vmalle1is	
	dsb	ish		
	isb			
	ret
END_FUNC tlbi_all
FUNC tlbi_mva_allasid , :
	lsr	x0, x0, #TLBI_MVA_SHIFT
	dsb	ishst		
	tlbi	vaae1is, x0	
	dsb	ish		
	isb			
	ret
END_FUNC tlbi_mva_allasid
FUNC tlbi_asid , :
	lsl	x0, x0, #TLBI_ASID_SHIFT
	dsb	ishst		
	tlbi	aside1is, x0	
	orr	x0, x0, #BIT(TLBI_ASID_SHIFT) 
	tlbi	aside1is, x0	
	dsb	ish		
	isb			
	ret
END_FUNC tlbi_asid
