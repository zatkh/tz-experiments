#ifndef TEE_MM_H
#define TEE_MM_H
#include <malloc.h>
#include <types_ext.h>
#define TEE_MM_POOL_NO_FLAGS            0
#define TEE_MM_POOL_HI_ALLOC            (1u << 0)
struct _tee_mm_entry_t {
	struct _tee_mm_pool_t *pool;
	struct _tee_mm_entry_t *next;
	uint32_t offset;	
	uint32_t size;		
};
typedef struct _tee_mm_entry_t tee_mm_entry_t;
struct _tee_mm_pool_t {
	tee_mm_entry_t *entry;
	paddr_t lo;		
	paddr_t hi;		
	uint32_t flags;		
	uint8_t shift;		
	unsigned int lock;
#ifdef CFG_WITH_STATS
	size_t max_allocated;
#endif
};
typedef struct _tee_mm_pool_t tee_mm_pool_t;
extern tee_mm_pool_t tee_mm_sec_ddr;
extern tee_mm_pool_t tee_mm_vcore;
extern tee_mm_pool_t tee_mm_shm;
tee_mm_entry_t *tee_mm_find(const tee_mm_pool_t *pool, paddr_t addr);
static inline bool tee_mm_validate(const tee_mm_pool_t *pool, paddr_t addr)
{
	return tee_mm_find(pool, addr) != 0;
}
uintptr_t tee_mm_get_smem(const tee_mm_entry_t *mm);
bool tee_mm_init(tee_mm_pool_t *pool, paddr_t lo, paddr_t hi, uint8_t shift,
		 uint32_t flags);
void tee_mm_final(tee_mm_pool_t *pool);
tee_mm_entry_t *tee_mm_alloc(tee_mm_pool_t *pool, size_t size);
tee_mm_entry_t *tee_mm_alloc2(tee_mm_pool_t *pool, paddr_t base, size_t size);
void tee_mm_free(tee_mm_entry_t *p);
static inline size_t tee_mm_get_size(tee_mm_entry_t *p)
{
	return p->size;
}
static inline uint32_t tee_mm_get_offset(tee_mm_entry_t *p)
{
	return p->offset;
}
size_t tee_mm_get_bytes(const tee_mm_entry_t *mm);
bool tee_mm_addr_is_within_range(tee_mm_pool_t *pool, paddr_t addr);
bool tee_mm_is_empty(tee_mm_pool_t *pool);
#ifdef CFG_WITH_STATS
void tee_mm_get_pool_stats(tee_mm_pool_t *pool, struct malloc_stats *stats,
			   bool reset);
#endif
#endif
