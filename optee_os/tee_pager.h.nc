#ifndef MM_TEE_PAGER_H
#define MM_TEE_PAGER_H
#include <kernel/abort.h>
#include <kernel/panic.h>
#include <kernel/user_ta.h>
#include <mm/tee_mm.h>
#include <mm/core_mmu.h>
#include <string.h>
#include <trace.h>
struct tee_pager_area_head;
void tee_pager_early_init(void);
bool tee_pager_get_table_info(vaddr_t va, struct core_mmu_table_info *ti);
void *tee_pager_phys_to_virt(paddr_t pa);
void tee_pager_init(tee_mm_entry_t *mm_alias);
void tee_pager_add_core_area(vaddr_t base, size_t size, uint32_t flags,
			     const void *store, const void *hashes);
#ifdef CFG_PAGED_USER_TA
bool tee_pager_add_uta_area(struct user_ta_ctx *utc, vaddr_t base, size_t size);
#else
static inline bool tee_pager_add_uta_area(struct user_ta_ctx *utc __unused,
					  vaddr_t base __unused,
					  size_t size __unused)
{
	return false;
}
#endif
#ifdef CFG_PAGED_USER_TA
bool tee_pager_set_uta_area_attr(struct user_ta_ctx *utc, vaddr_t base,
				 size_t size, uint32_t flags);
#else
static inline bool tee_pager_set_uta_area_attr(struct user_ta_ctx *utc __unused,
					       vaddr_t base __unused,
					       size_t size __unused,
					       uint32_t flags __unused)
{
	return false;
}
#endif
void tee_pager_transfer_uta_region(struct user_ta_ctx *src_utc,
				   vaddr_t src_base,
				   struct user_ta_ctx *dst_utc,
				   vaddr_t dst_base, struct pgt **dst_pgt,
				   size_t size);
void tee_pager_rem_uta_region(struct user_ta_ctx *utc, vaddr_t base,
			      size_t size);
#ifdef CFG_PAGED_USER_TA
void tee_pager_rem_uta_areas(struct user_ta_ctx *utc);
#else
static inline void tee_pager_rem_uta_areas(struct user_ta_ctx *utc __unused)
{
}
#endif
#ifdef CFG_PAGED_USER_TA
void tee_pager_assign_uta_tables(struct user_ta_ctx *utc);
#else
static inline void tee_pager_assign_uta_tables(struct user_ta_ctx *utc __unused)
{
}
#endif
void tee_pager_add_pages(vaddr_t vaddr, size_t npages, bool unmap);
void *tee_pager_alloc(size_t size, uint32_t flags);
#ifdef CFG_PAGED_USER_TA
void tee_pager_pgt_save_and_release_entries(struct pgt *pgt);
#endif
#ifdef CFG_WITH_PAGER
void tee_pager_release_phys(void *addr, size_t size);
#else
static inline void tee_pager_release_phys(void *addr __unused,
			size_t size __unused)
{
}
#endif
struct tee_pager_stats {
	size_t hidden_hits;
	size_t ro_hits;
	size_t rw_hits;
	size_t zi_released;
	size_t npages;		
	size_t npages_all;	
};
#ifdef CFG_WITH_PAGER
void tee_pager_get_stats(struct tee_pager_stats *stats);
bool tee_pager_handle_fault(struct abort_info *ai);
#else 
static inline bool tee_pager_handle_fault(struct abort_info *ai __unused)
{
	return false;
}
static inline void tee_pager_get_stats(struct tee_pager_stats *stats)
{
	memset(stats, 0, sizeof(struct tee_pager_stats));
}
#endif 
#endif 
