#include <kernel/tee_ta_manager.h>
#include <mm/tee_mmu.h>
#include <tee/cache.h>
#include <tee/svc_cache.h>
TEE_Result syscall_cache_operation(void *va, size_t len, unsigned long op)
{
	TEE_Result res;
	struct tee_ta_session *sess;
	struct user_ta_ctx *utc;
	res = tee_ta_get_current_session(&sess);
	if (res != TEE_SUCCESS)
		return res;
	if ((sess->ctx->flags & TA_FLAG_CACHE_MAINTENANCE) == 0)
		return TEE_ERROR_NOT_SUPPORTED;
	utc = to_user_ta_ctx(sess->ctx);
	if (tee_mmu_is_vbuf_intersect_ta_private(utc, va, len))
		return TEE_ERROR_ACCESS_DENIED;
	res = tee_mmu_check_access_rights(utc, TEE_MEMORY_ACCESS_READ |
					  TEE_MEMORY_ACCESS_ANY_OWNER,
					  (uaddr_t)va, len);
	if (res != TEE_SUCCESS)
		return TEE_ERROR_ACCESS_DENIED;
	return cache_operation(op, va, len);
}
