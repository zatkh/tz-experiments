#include <initcall.h>
#include <kernel/linker.h>
#include <kernel/tee_misc.h>
#include <kernel/time_source.h>
#include <malloc.h>		
#include <mm/core_memprot.h>
#include <mm/tee_mmu.h>
#include <sm/tee_mon.h>
#include <tee/tee_fs.h>
#include <tee/tee_svc.h>
#include <trace.h>
#include <platform_config.h>
#define TEE_MON_MAX_NUM_ARGS    8
static void call_initcalls(void)
{
	const initcall_t *call;
	for (call = &__initcall_start; call < &__initcall_end; call++) {
		TEE_Result ret;
		ret = (*call)();
		if (ret != TEE_SUCCESS) {
			EMSG("Initial call 0x%08" PRIxVA " failed",
			     (vaddr_t)call);
		}
	}
}
TEE_Result __weak init_teecore(void)
{
	static int is_first = 1;
	if (!is_first)
		return TEE_SUCCESS;
	is_first = 0;
#ifdef CFG_WITH_USER_TA
	tee_svc_uref_base = TEE_TEXT_VA_START;
#endif
	teecore_init_pub_ram();
	time_source_init();
	call_initcalls();
	IMSG("Initialized");
	return TEE_SUCCESS;
}
