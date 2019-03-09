#include <arm.h>
#include <kernel/misc.h>
#include <kernel/msg_param.h>
#include <kernel/pseudo_ta.h>
#include <kernel/user_ta.h>
#include <kernel/thread.h>
#include <kernel/tee_time.h>
#include <mm/core_memprot.h>
#include <mm/mobj.h>
#include <mm/tee_mmu.h>
#include <optee_msg_supplicant.h>
#include <enclave-test-driver.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <console.h>
#define ENCLAVE_NAME "test_enclave.pta" 
#define ENCLAVE_NAME_MAX 350
static TEE_Result ocall_test(uint32_t param_types __unused,
			TEE_Param params[TEE_NUM_PARAMS] )
{
	struct optee_msg_param rpc_params;
	static struct mutex reg_mu = MUTEX_INITIALIZER;
	TEE_Result res;
	memset(&rpc_params, 0, sizeof(rpc_params));
	rpc_params.attr = OPTEE_MSG_ATTR_TYPE_VALUE_INOUT;
	rpc_params.u.value.a = params[0].value.a;
	 res=thread_rpc_cmd(OCALL_TEST, 1, &rpc_params);
	IMSG("empty \n" );
	 return TEE_SUCCESS;
}
static TEE_Result ocall_open(uint32_t param_types __unused,TEE_Param params[TEE_NUM_PARAMS])
{
	struct optee_msg_param rpc_params[2];
	struct mobj *mobj;
	uint64_t c = 0;
	uint64_t ret;
	char *va;
	uint32_t len=params[0].memref.size;
	IMSG("[snape:ocall_open], name is %s,len is %d",( char*) params[0].memref.buffer, len);
	mobj = thread_rpc_alloc_payload( len, &c);
	if (!mobj)
		return TEE_ERROR_OUT_OF_MEMORY;
	va = mobj_get_va(mobj, 0);
	if (!va)
		return TEE_ERROR_OUT_OF_MEMORY;
	memcpy(va, params[0].memref.buffer, len);	
	memset(rpc_params, 0, sizeof(rpc_params));
	if (!msg_param_init_memparam(rpc_params + 0, mobj, 0,len, c,MSG_PARAM_MEM_DIR_IN))
		return TEE_ERROR_BAD_STATE;
	rpc_params[1].attr = OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT;
	rpc_params[1].u.value.a=0;
	TEE_Result res;
	IMSG("[ocall_tap_open] before rpc \n");
	res=thread_rpc_cmd(OCALL_OPEN, 2, &rpc_params);
	params[1].value.a=rpc_params[1].u.value.a;
	IMSG("[ocall_tap_open] fd(%d)", params[1].value.a);
	thread_rpc_free_payload(c, mobj);
	return res;
}
static TEE_Result ocall_write(uint32_t param_types __unused,TEE_Param params[TEE_NUM_PARAMS])
{
	struct optee_msg_param rpc_params[3];
	struct mobj *mobj;
	uint64_t c = 0;
	uint64_t ret;
	char *va;
	int fd=params[0].value.a;
	uint32_t len=params[1].memref.size;
	mobj = thread_rpc_alloc_payload( len, &c);
	if (!mobj)
		return TEE_ERROR_OUT_OF_MEMORY;
	va = mobj_get_va(mobj, 0);
	if (!va)
		return TEE_ERROR_OUT_OF_MEMORY;
	memcpy(va, params[1].memref.buffer, len);	
	memset(rpc_params, 0, sizeof(rpc_params));
	rpc_params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
	rpc_params[0].u.value.a= fd;
	if (!msg_param_init_memparam(rpc_params + 1, mobj, 0,len, c,MSG_PARAM_MEM_DIR_IN))
		return TEE_ERROR_BAD_STATE;
	rpc_params[2].attr = OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT;
	rpc_params[2].u.value.a=0;
	TEE_Result res;
	res=thread_rpc_cmd(OCALL_WRITE, 3, &rpc_params);
	params[2].value.a=rpc_params[2].u.value.a;
	thread_rpc_free_payload(c, mobj);
	return res;
}
static TEE_Result ocall_read(uint32_t param_types __unused,TEE_Param params[TEE_NUM_PARAMS])
{
	struct optee_msg_param rpc_params[3];
	struct mobj *mobj;
	uint64_t c = 0;
	uint64_t ret;
	char *va;
	int fd=params[0].value.a;
	uint32_t len=params[2].value.a;
	uint32_t exp_pt = TEE_PARAM_TYPES(TEE_PARAM_TYPE_VALUE_INPUT,
					  TEE_PARAM_TYPE_MEMREF_OUTPUT,
					  TEE_PARAM_TYPE_VALUE_INPUT,
					  TEE_PARAM_TYPE_MEMREF_OUTPUT);
	if (exp_pt != param_types)
		return TEE_ERROR_BAD_PARAMETERS;
	mobj = thread_rpc_alloc_payload( ENCLAVE_NAME_MAX, &c);
	if (!mobj)
		return TEE_ERROR_OUT_OF_MEMORY;
	va = mobj_get_va(mobj, 0);
	if (!va)
		return TEE_ERROR_OUT_OF_MEMORY;
	memcpy(va, params[1].memref.buffer, len);	
	memset(rpc_params, 0, sizeof(rpc_params));
	rpc_params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
	rpc_params[0].u.value.a= fd;
	if (!msg_param_init_memparam(rpc_params + 1, mobj, 0,len, c,MSG_PARAM_MEM_DIR_OUT))
		return TEE_ERROR_BAD_STATE;
	rpc_params[2].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
	rpc_params[2].u.value.a= len;
	TEE_Result res;
	res=thread_rpc_cmd(OCALL_READ, 3, &rpc_params);
	params[1].memref.size = msg_param_get_buf_size(rpc_params + 1);
	if (params[1].memref.size)
		memcpy(params[1].memref.buffer, va, params[1].memref.size);
 	char temp[params[1].memref.size] ;
	params[3].memref.size=sizeof(temp);
		memcpy(params[3].memref.buffer, params[1].memref.buffer, params[1].memref.size);
	return res;
}
static TEE_Result ocall_close(uint32_t param_types __unused,
			TEE_Param params[TEE_NUM_PARAMS])
{
	struct optee_msg_param rpc_params;
	static struct mutex reg_mu = MUTEX_INITIALIZER;
	TEE_Result res;
	memset(&rpc_params, 0, sizeof(rpc_params));
	rpc_params.attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
	rpc_params.u.value.a = params[0].value.a;
	res=thread_rpc_cmd(OCALL_CLOSE, 1, &rpc_params);
	IMSG("ocall_close\n" );
	 return TEE_SUCCESS;
}
static TEE_Result ocall_tap_open(uint32_t param_types __unused,TEE_Param params[TEE_NUM_PARAMS])
{
	struct optee_msg_param rpc_params[2];
	struct mobj *mobj;
	uint64_t c = 0;
	uint64_t ret;
	char *va;
	uint32_t len=params[0].memref.size;
	IMSG("ocall_tap_open, name is %s,len is %d",( char*) params[0].memref.buffer, len);
	mobj = thread_rpc_alloc_payload( len, &c);
	if (!mobj)
		return TEE_ERROR_OUT_OF_MEMORY;
	va = mobj_get_va(mobj, 0);
	if (!va)
		return TEE_ERROR_OUT_OF_MEMORY;
	memcpy(va, params[0].memref.buffer, len);	
	memset(rpc_params, 0, sizeof(rpc_params));
	rpc_params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
	rpc_params[0].u.value.a = 1992;
	if (!msg_param_init_memparam(rpc_params + 1, mobj, 0,len, c,MSG_PARAM_MEM_DIR_IN))
		return TEE_ERROR_BAD_STATE;
	rpc_params[2].attr = OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT;
	rpc_params[2].u.value.a=0;
	TEE_Result res;
	IMSG("[ocall_tap_open] before rpc \n");
	res=thread_rpc_cmd(OCALL_TAP_OPEN, 3, &rpc_params);
	params[1].value.a=rpc_params[2].u.value.a;
	IMSG("[ocall_tap_open] fd(%d)", params[1].value.a);
	thread_rpc_free_payload(c, mobj);
	return res;
	return TEE_SUCCESS;
}
int usleep(uint32_t param_types,TEE_Param params[TEE_NUM_PARAMS] )
{
	int microsec=params[0].value.a;
	tee_time_busy_wait((uint32_t )(microsec/1000));
	return 0;
}
static TEE_Result test_hello(uint32_t param_types __unused,
			TEE_Param params[TEE_NUM_PARAMS] __unused)
{
   IMSG("[test_hello]hey this is a new test PTA \n" );
   char c;
 	 IMSG("[test_hello]Enter character: ");
   c = console_getc();
   IMSG("[test_hello]Character entered: ");
   console_putc(c);
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
static TEE_Result file_ocall(uint32_t param_types __unused,
			TEE_Param params[TEE_NUM_PARAMS] __unused)
{
	struct optee_msg_param rpc_params;
	TEE_Result res;
	memset(&rpc_params, 0, sizeof(rpc_params));
	 res=thread_rpc_cmd(OCALL_FILE_BENCH,0, &rpc_params);
	 return TEE_SUCCESS;
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
	case OCALL_FILE:
		return file_ocall(nParamTypes, pParams);
	case USLEEP:
		return usleep(nParamTypes, pParams);
    case O_CLOSE:
        return ocall_close (nParamTypes, pParams); 
	case O_READ:
		return ocall_read(nParamTypes, pParams);
	case O_WRITE:
		return ocall_write(nParamTypes, pParams);	 
	case O_TAP_OPEN:
		return ocall_tap_open(nParamTypes, pParams); 
	case O_OPEN:
		return ocall_open(nParamTypes, pParams);				
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
