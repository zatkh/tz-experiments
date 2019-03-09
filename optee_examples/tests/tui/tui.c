
#include <tee_internal_api.h>
#include <tee_internal_api_extensions.h>
#include <tui_enclave.h>
#include <stdlib.h>

TEE_TASessionHandle snape_sess;
const TEE_UUID snape_uuid = SNAPE_DRIVER_UUID;

/*
 * Called when the instance of the TA is created. This is the first call in
 * the TA.
 */
TEE_Result TA_CreateEntryPoint(void)
{
	DMSG("has been called");

		TEE_Result res;
	
	res = TEE_OpenTASession(&snape_uuid, 0, 0, NULL, &snape_sess, NULL);
		if (res != TEE_SUCCESS)
			return res;

	return TEE_SUCCESS;
}

/*
 * Called when the instance of the TA is destroyed if the TA has not
 * crashed or panicked. This is the last call in the TA.
 */
void TA_DestroyEntryPoint(void)
{
	DMSG("has been called");

	TEE_CloseTASession(snape_sess);
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


static void *memcpy(void *restrict dest, const void *restrict src, size_t n)
{
    unsigned char *d = dest;
    const unsigned char *s = src;

    for (; n; n--) *d++ = *s++;
    return dest;
}

static TEE_Result ecall_puts(uint32_t param_types,
	TEE_Param params[4])
{
	
	uint32_t exp_param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_MEMREF_INPUT,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE);


	if (param_types != exp_param_types)
		return TEE_ERROR_BAD_PARAMETERS;
	size_t len=params[0].memref.size;
	char buffer[len]; 
 
    snprintf(buffer,len, "%s\n",( char *)params[0].memref.buffer); 
    printf("%s\n", buffer); 

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
	case ECALL_PUTS:
		return ecall_puts(param_types, params);

	
	default:
		return TEE_ERROR_BAD_PARAMETERS;
	}
}
