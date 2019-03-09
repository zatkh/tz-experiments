#include <arm.h>
#include <kernel/misc.h>
#include <kernel/msg_param.h>
#include <kernel/pseudo_ta.h>
#include <kernel/user_ta.h>
#include <kernel/thread.h>
#include <mm/core_memprot.h>
#include <mm/mobj.h>
#include <mm/tee_mmu.h>
#include <optee_msg_supplicant.h>
#include <test_hello.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#define ENCLAVE_NAME "test_enclave.pta" 
static TEE_Result ocall_test(uint32_t param_types __unused,
			TEE_Param params[TEE_NUM_PARAMS] __unused)
{
	struct optee_msg_param rpc_params;
	static struct mutex reg_mu = MUTEX_INITIALIZER;
	TEE_Result res;
	memset(&rpc_params, 0, sizeof(rpc_params));
	rpc_params.attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
	rpc_params.u.value.a = 12;
	rpc_params.u.value.b = 13;
	rpc_params.u.value.c = 14;
	 res=thread_rpc_cmd(OCALL_TEST, 1, &rpc_params);
	IMSG("empty \n" );
	 return TEE_SUCCESS;
}
static TEE_Result test_hello(uint32_t param_types __unused,
			TEE_Param params[TEE_NUM_PARAMS] __unused)
{
	IMSG("hey this is a new test PTA \n" );
	return TEE_SUCCESS;
}
static TEE_Result open_session(uint32_t nParamTypes __unused,
		TEE_Param pParams[TEE_NUM_PARAMS] __unused,
		void **ppSessionContext __unused)
{
	DMSG("open entry point for pseudo ta \"%s\"", ENCLAVE_NAME);
	return TEE_SUCCESS;
}
static void close_session(void *pSessionContext __unused)
{
	DMSG("close entry point for pseudo ta \"%s\"", ENCLAVE_NAME);
}
static TEE_Result create_ta(void)
{
	DMSG("create entry point for pseudo TA \"%s\"", ENCLAVE_NAME);
	return TEE_SUCCESS;
}
static void destroy_ta(void)
{
	DMSG("destroy entry point for pseudo ta \"%s\"", ENCLAVE_NAME);
}
static TEE_Result invoke_command(void *pSessionContext __unused,
				 uint32_t nCommandID, uint32_t nParamTypes,
				 TEE_Param pParams[TEE_NUM_PARAMS])
{
	FMSG("command entry point for pseudo-TA \"%s\"", ENCLAVE_NAME);
	switch (nCommandID) {
	case ENCLAVE_CONSOLE_TEST:
		return test_hello(nParamTypes, pParams);
	case ECALL_TEST:
		return ocall_test(nParamTypes, pParams);	
	default:
		break;
	}
	return TEE_ERROR_NOT_IMPLEMENTED;
}
pseudo_ta_register(.uuid = TEST_ENCLAVE_UUID, .name = ENCLAVE_NAME,
		   .flags = PTA_DEFAULT_FLAGS | TA_FLAG_SECURE_DATA_PATH |
			    TA_FLAG_CONCURRENT,
		   .create_entry_point = create_ta,
		   .destroy_entry_point = destroy_ta,
		   .open_session_entry_point = open_session,
		   .close_session_entry_point = close_session,
		   .invoke_command_entry_point = invoke_command);
