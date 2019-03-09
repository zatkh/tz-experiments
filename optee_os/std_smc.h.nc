#ifndef __STD_SMC_H__
#define __STD_SMC_H__
#include <sm/sm.h>
#define ARM_STD_SVC_CALL_COUNT		0x8400ff00
#define ARM_STD_SVC_UID			0x8400ff01
#define ARM_STD_SVC_VERSION		0x8400ff03
#define STD_SVC_VERSION_MAJOR		0x0
#define STD_SVC_VERSION_MINOR		0x1
#define PSCI_FID_MASK			0xffe0u
#define PSCI_FID_VALUE			0u
#define is_psci_fid(_fid) \
	(((_fid) & PSCI_FID_MASK) == PSCI_FID_VALUE)
void smc_std_handler(struct thread_smc_args *args, struct sm_nsec_ctx *nsec);
#endif
