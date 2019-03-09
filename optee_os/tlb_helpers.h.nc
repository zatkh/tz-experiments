#ifndef TLB_HELPERS_H
#define TLB_HELPERS_H
#include <arm.h>
#ifndef ASM
#include <types_ext.h>
void tlbi_all(void);
void tlbi_asid(unsigned long asid);
void tlbi_mva_allasid(unsigned long addr);
static inline void tlbi_mva_allasid_nosync(vaddr_t va)
{
#ifdef ARM64
	tlbi_vaae1is(va >> TLBI_MVA_SHIFT);
#else
	write_tlbimvaais(va);
#endif
}
#endif 
#endif 
