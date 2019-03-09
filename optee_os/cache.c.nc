#include <mm/core_memprot.h>
#include <mm/core_mmu.h>
#include <tee/cache.h>
TEE_Result cache_operation(enum utee_cache_operation op, void *va, size_t len)
{
	TEE_Result res;
	paddr_t pa;
	pa = virt_to_phys(va);
	if (!pa)
		return TEE_ERROR_ACCESS_DENIED;
	switch (op) {
	case TEE_CACHEFLUSH:
#ifdef CFG_PL310 
		res = cache_op_inner(DCACHE_AREA_CLEAN, va, len);
		if (res != TEE_SUCCESS)
			return res;
		res = cache_op_outer(DCACHE_AREA_CLEAN_INV, pa, len);
		if (res != TEE_SUCCESS)
			return res;
#endif
		return cache_op_inner(DCACHE_AREA_CLEAN_INV, va, len);
	case TEE_CACHECLEAN:
		res = cache_op_inner(DCACHE_AREA_CLEAN, va, len);
		if (res != TEE_SUCCESS)
			return res;
		return cache_op_outer(DCACHE_AREA_CLEAN, pa, len);
	case TEE_CACHEINVALIDATE:
		res = cache_op_outer(DCACHE_AREA_INVALIDATE, pa, len);
		if (res != TEE_SUCCESS)
			return res;
		return cache_op_inner(DCACHE_AREA_INVALIDATE, va, len);
	default:
		return TEE_ERROR_NOT_SUPPORTED;
	}
}
