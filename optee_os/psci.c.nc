#include <console.h>
#include <kernel/generic_boot.h>
#include <kernel/thread.h>
#include <stdint.h>
#include <sm/optee_smc.h>
#include <sm/psci.h>
#include <sm/sm.h>
#include <trace.h>
__weak uint32_t psci_version(void)
{
	return PSCI_VERSION_0_2;
}
__weak int psci_cpu_suspend(uint32_t power_state __unused,
			    uintptr_t entry __unused,
			    uint32_t context_id __unused,
			    struct sm_nsec_ctx *nsec __unused)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_cpu_off(void)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_cpu_on(uint32_t cpu_id __unused, uint32_t entry __unused,
		       uint32_t context_id __unused)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_affinity_info(uint32_t affinity __unused,
			      uint32_t lowest_affnity_level __unused)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_migrate(uint32_t cpu_id __unused)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_migrate_info_type(void)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_migrate_info_up_cpu(void)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak void psci_system_off(void)
{
}
__weak void psci_system_reset(void)
{
}
__weak int psci_features(uint32_t psci_fid __unused)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_node_hw_state(uint32_t cpu_id __unused,
			      uint32_t power_level __unused)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_system_suspend(uintptr_t entry __unused,
			       uint32_t context_id __unused,
			       struct sm_nsec_ctx *nsec __unused)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_stat_residency(uint32_t cpu_id __unused,
			       uint32_t power_state __unused)
{
	return PSCI_RET_NOT_SUPPORTED;
}
__weak int psci_stat_count(uint32_t cpu_id __unused,
			   uint32_t power_state __unused)
{
	return PSCI_RET_NOT_SUPPORTED;
}
void tee_psci_handler(struct thread_smc_args *args, struct sm_nsec_ctx *nsec)
{
	uint32_t smc_fid = args->a0;
	uint32_t a1 = args->a1;
	uint32_t a2 = args->a2;
	uint32_t a3 = args->a3;
	switch (smc_fid) {
	case PSCI_VERSION:
		args->a0 = psci_version();
		break;
	case PSCI_CPU_SUSPEND:
		args->a0 = psci_cpu_suspend(a1, a2, a3, nsec);
		break;
	case PSCI_CPU_OFF:
		args->a0 = psci_cpu_off();
		break;
	case PSCI_CPU_ON:
		args->a0 = psci_cpu_on(a1, a2, a3);
		break;
	case PSCI_AFFINITY_INFO:
		args->a0 = psci_affinity_info(a1, a2);
		break;
	case PSCI_MIGRATE:
		args->a0 = psci_migrate(a1);
		break;
	case PSCI_MIGRATE_INFO_TYPE:
		args->a0 = psci_migrate_info_type();
		break;
	case PSCI_MIGRATE_INFO_UP_CPU:
		args->a0 = psci_migrate_info_up_cpu();
		break;
	case PSCI_SYSTEM_OFF:
		psci_system_off();
		while (1)
			;
		break;
	case PSCI_SYSTEM_RESET:
		psci_system_reset();
		while (1)
			;
		break;
	case PSCI_PSCI_FEATURES:
		args->a0 = psci_features(a1);
		break;
	case PSCI_NODE_HW_STATE:
		args->a0 = psci_node_hw_state(a1, a2);
		break;
	case PSCI_SYSTEM_SUSPEND:
		args->a0 = psci_system_suspend(a1, a2, nsec);
		break;
	default:
		args->a0 = OPTEE_SMC_RETURN_UNKNOWN_FUNCTION;
		break;
	}
}
