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


#define THELLO_PTA_NAME "thello.pta" 



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
	DMSG("open entry point for pseudo ta \"%s\"", THELLO_PTA_NAME);
	return TEE_SUCCESS;
}

static void close_session(void *pSessionContext __unused)
{
	DMSG("close entry point for pseudo ta \"%s\"", THELLO_PTA_NAME);
}

/*
 * Trusted Application Entry Points
 */

static TEE_Result create_ta(void)
{
	DMSG("create entry point for pseudo TA \"%s\"", THELLO_PTA_NAME);
	return TEE_SUCCESS;
}

static void destroy_ta(void)
{
	DMSG("destroy entry point for pseudo ta \"%s\"", THELLO_PTA_NAME);
}

static TEE_Result invoke_command(void *pSessionContext __unused,
				 uint32_t nCommandID, uint32_t nParamTypes,
				 TEE_Param pParams[TEE_NUM_PARAMS])
{
	FMSG("command entry point for pseudo-TA \"%s\"", THELLO_PTA_NAME);

	switch (nCommandID) {
	case PTA_HELLO:
		return test_hello(nParamTypes, pParams);
	default:
		break;
	}

	return TEE_ERROR_NOT_IMPLEMENTED;
}


pseudo_ta_register(.uuid = PTA_THELLO_UUID, .name = THELLO_PTA_NAME,
		   .flags = PTA_DEFAULT_FLAGS | TA_FLAG_SECURE_DATA_PATH |
			    TA_FLAG_CONCURRENT,
		   .create_entry_point = create_ta,
		   .destroy_entry_point = destroy_ta,
		   .open_session_entry_point = open_session,
		   .close_session_entry_point = close_session,
		   .invoke_command_entry_point = invoke_command);


