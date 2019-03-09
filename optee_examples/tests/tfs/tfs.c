
#include <tee_internal_api.h>
#include <tee_internal_api_extensions.h>
#include <tfs_enclave.h>
#include <stdlib.h>
#include "test_bmfs.h"

/*
 * Called when the instance of the TA is created. This is the first call in
 * the TA.
 */
TEE_Result TA_CreateEntryPoint(void)
{
	DMSG("has been called");

	return TEE_SUCCESS;
}

/*
 * Called when the instance of the TA is destroyed if the TA has not
 * crashed or panicked. This is the last call in the TA.
 */
void TA_DestroyEntryPoint(void)
{
	DMSG("has been called");

}

/*
 * Called when a new session is opened to the TA. *sess_ctx can be updated
 * with a value to be able to identify this session in subsequent calls to the
 * TA. In this function you will normally do the global initialization for the
 * TA.
 */
TEE_Result TA_OpenSessionEntryPoint(uint32_t param_types,
		TEE_Param __maybe_unused params[4],
		void __maybe_unused **sess_ctx)
{
	uint32_t exp_param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE);

	DMSG("has been called");

	if (param_types != exp_param_types)
		return TEE_ERROR_BAD_PARAMETERS;

	/* Unused parameters */
	(void)&params;
	(void)&sess_ctx;

	/*
	 * The DMSG() macro is non-standard, TEE Internal API doesn't
	 * specify any means to logging from a TA.
	 */
	IMSG("Hello World!\n");

	/* If return value != TEE_SUCCESS the session will not be created. */
	return TEE_SUCCESS;
}

/*
 * Called when a session is closed, sess_ctx hold the value that was
 * assigned by TA_OpenSessionEntryPoint().
 */
void TA_CloseSessionEntryPoint(void __maybe_unused *sess_ctx)
{
	(void)&sess_ctx; /* Unused parameter */
	IMSG("Goodbye!\n");
}



static TEE_Result inc_value(uint32_t param_types,
	TEE_Param params[4])
{
	uint32_t exp_param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_VALUE_INOUT,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE);

	DMSG("has been called");

	if (param_types != exp_param_types)
		return TEE_ERROR_BAD_PARAMETERS;

	IMSG("Got value: %u from NW", params[0].value.a);
	params[0].value.a++;
	IMSG("Increase value to: %u", params[0].value.a);

	

	return TEE_SUCCESS;
}




static TEE_Result ecall_fs_test(uint32_t __unused param_types,
					TEE_Param  __unused params[4])

{

	int ret;
	printf ("[ecall_fs_test] enter\n");
	ret= bmfs_test();
	if(ret == 0)
	printf ("[ecall_fs_test] success\n");
	else 
	printf ("[ecall_fs_test] failed\n");

	return TEE_SUCCESS;
}

static TEE_Result ecall_open(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{
	bmfs_open_file_test();
	

	return TEE_SUCCESS;
}

static TEE_Result ecall_read(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{

	bmfs_read_file_test();


	return TEE_SUCCESS;
}

static TEE_Result ecall_write(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{

	bmfs_write_file_test();
	return TEE_SUCCESS;
}

static TEE_Result ecall_seek(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{

	bmfs_seek_file_test();

	return TEE_SUCCESS;
}

static TEE_Result ecall_cleanup(uint32_t __unused param_types,
					TEE_Param __unused params[4])
					
{
	 	bmfs_cleanup();
		return TEE_SUCCESS;
}

static TEE_Result ecall_create(uint32_t __unused param_types,
					TEE_Param __unused params[4])
					
{
	 	 bmfs_create_file_test();
		return TEE_SUCCESS;
}

static TEE_Result ecall_close(uint32_t __unused param_types,
					TEE_Param __unused params[4])
					
{
	 	  bmfs_close_file_test();
		return TEE_SUCCESS;
}

static TEE_Result ecall_init_p_file(uint32_t __unused param_types,
					TEE_Param __unused params[4])
					
{
	 	init_p_file();
		return TEE_SUCCESS;
}



TEE_Result TA_InvokeCommandEntryPoint(void __maybe_unused *sess_ctx,
			uint32_t cmd_id,
			uint32_t param_types, TEE_Param params[4])
{
	(void)&sess_ctx; /* Unused parameter */

	switch (cmd_id) {
	case TA_HELLO_WORLD_CMD_INC_VALUE:
		return inc_value(param_types, params);
	case ECALL_BMFS_TEST:
		return ecall_fs_test(param_types, params);
	case ECALL_CREATE:
		return ecall_create(param_types, params);
	case ECALL_OPEN:
		return ecall_open(param_types, params);	
	case ECALL_WRITE:
		return ecall_write(param_types, params);
	case ECALL_READ:
		return ecall_read(param_types, params);
	case ECALL_SEEK:
		return ecall_seek(param_types, params);
	case ECALL_CLOSE:
		return ecall_close(param_types, params);
	case ECALL_BMFS_CLEAN:
		return ecall_cleanup(param_types, params);
	case ECALL_INIT_PRIVATE_FILE:
		return ecall_init_p_file(param_types, params);
	
	default:
		return TEE_ERROR_BAD_PARAMETERS;
	}
}


