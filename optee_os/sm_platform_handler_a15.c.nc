#include <arm32.h>
#include <sm/sm.h>
#include "api_monitor_index_a15.h"
bool sm_platform_handler(struct sm_ctx *ctx)
{
	if (ctx->nsec.r12 == 0x200)
		return true;
	switch (ctx->nsec.r12) {
	case API_MONITOR_ACTLR_SETREGISTER_INDEX:
		write_actlr(ctx->nsec.r0);
		isb();
		ctx->nsec.r0 = API_HAL_RET_VALUE_OK;
		break;
	case API_MONITOR_TIMER_SETCNTFRQ_INDEX:
		write_cntfrq(ctx->nsec.r0);
		isb();
		ctx->nsec.r0 = API_HAL_RET_VALUE_OK;
		break;
	default:
		ctx->nsec.r0 = API_HAL_RET_VALUE_SERVICE_UNKNWON;
		break;
	}
	return false;
}
