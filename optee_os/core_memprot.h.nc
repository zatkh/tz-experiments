#ifndef CORE_MEMPROT_H
#define CORE_MEMPROT_H
#include <mm/core_mmu.h>
#include <types_ext.h>
enum buf_is_attr {
	CORE_MEM_CACHED,
	CORE_MEM_NSEC_SHM,
	CORE_MEM_NON_SEC,
	CORE_MEM_SEC,
	CORE_MEM_TEE_RAM,
	CORE_MEM_TA_RAM,
	CORE_MEM_SDP_MEM,
	CORE_MEM_REG_SHM,
};
#define tee_pbuf_is     core_pbuf_is
#define tee_vbuf_is     core_vbuf_is
#define tee_pbuf_is_non_sec(buf, len) \
		core_pbuf_is(CORE_MEM_NON_SEC, (paddr_t)(buf), (len))
#define tee_pbuf_is_sec(buf, len) \
		core_pbuf_is(CORE_MEM_SEC, (paddr_t)(buf), (len))
#define tee_vbuf_is_non_sec(buf, len) \
		core_vbuf_is(CORE_MEM_NON_SEC, (void *)(buf), (len))
#define tee_vbuf_is_sec(buf, len) \
		core_vbuf_is(CORE_MEM_SEC, (void *)(buf), (len))
bool core_pbuf_is(uint32_t flags, paddr_t pbuf, size_t len);
bool core_vbuf_is(uint32_t flags, const void *vbuf, size_t len);
void *phys_to_virt(paddr_t pa, enum teecore_memtypes m);
void *phys_to_virt_io(paddr_t pa);
paddr_t virt_to_phys(void *va);
vaddr_t core_mmu_get_va(paddr_t pa, enum teecore_memtypes type);
#endif 
