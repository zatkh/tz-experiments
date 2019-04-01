
#include <tee_internal_api.h>
#include <tee_internal_api_extensions.h>
#include <main_ta.h>
#include <stdlib.h>
#include <time.h>
#include <tee_api.h>
//#include "test_bmfs.h"
#include "test_libm.h"
//#include "caml/backtrace_prim.h"


TEE_TASessionHandle snape_sess;
const TEE_UUID snape_uuid = TEST_ENCLAVE_UUID;

/*
 * Called when the instance of the TA is created. This is the first call in
 * the TA.
 */
TEE_Result TA_CreateEntryPoint(void)
{
	DMSG("ya has been called");
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

/*

static TEE_Result bmfs_test_call(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{
	int ret;
	printf ("[bmfs_test_call] enter\n");
	ret= bmfs_test();
	if(ret == 0)
	printf ("[bmfs_test_call] success\n");
	else
	printf ("[bmfs_test_call] failed\n");

	return TEE_SUCCESS;
}

static TEE_Result bmfs_test_open_call(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{
	bmfs_open_file_test();


	return TEE_SUCCESS;
}

static TEE_Result bmfs_test_read_call(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{

	bmfs_read_file_test();


	return TEE_SUCCESS;
}

static TEE_Result bmfs_test_write_call(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{

	bmfs_write_file_test();
	return TEE_SUCCESS;
}

static TEE_Result bmfs_test_seek_call(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{

	bmfs_seek_file_test();

	return TEE_SUCCESS;
}

static TEE_Result ta_bmfs_cleanup(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{
	 	bmfs_cleanup();
		return TEE_SUCCESS;
}

*/

extern void caml_startup(char ** argv);

static TEE_Result libasmrun_test(uint32_t __unused param_types,
					TEE_Param __unused params[4])
{

	char** argv = {""};
	printf ("[ocaml_test] enter\n");
	caml_startup(argv);
	printf ("[ocaml_test] success\n");

	return TEE_SUCCESS;


}


static TEE_Result libm_test_call(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{
	printf ("[libm_test_call] enter\n");
	test_libm();
	printf ("[libm_test_call] success\n");

	return TEE_SUCCESS;
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

	 //libasmrun_test();


	return TEE_SUCCESS;
}




static TEE_Result empty_test(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{

		return TEE_SUCCESS;
}

static TEE_Result pta_test(uint32_t __unused param_types,
					TEE_Param __unused params[4])

{

	TEE_Result res;
	uint32_t err_origin;

//printf("after opening pta session\n");
	res = TEE_InvokeTACommand(snape_sess, 0, OCALL_FILE, param_types, params, &err_origin);
	//printf("after pta test $d\n",err_origin);


	return res;
}



static TEE_Result ecall_time(uint32_t param_types,TEE_Param params[4])
{
	uint32_t exp_param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_VALUE_OUTPUT,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE);


	if (param_types != exp_param_types)
		return TEE_ERROR_BAD_PARAMETERS;

	TEE_Time _time;
	TEE_GetSystemTime(&_time);
    params[0].value.a = _time.seconds;


	return TEE_SUCCESS;
}



/*
 * Called when a TA is invoked. sess_ctx hold that value that was
 * assigned by TA_OpenSessionEntryPoint(). The rest of the paramters
 * comes from normal world.
 */
TEE_Result TA_InvokeCommandEntryPoint(void __maybe_unused *sess_ctx,
			uint32_t cmd_id,
			uint32_t param_types, TEE_Param params[4])
{
	(void)&sess_ctx; /* Unused parameter */

	switch (cmd_id) {
/*
	case TA_BMFS_TEST:
		return bmfs_test_call(param_types, params);
	case TA_OPEN_FILE_TEST:
		return bmfs_test_open_call(param_types, params);
	case TA_WRITE_FILE_TEST:
		return bmfs_test_write_call(param_types, params);
	case TA_READ_FILE_TEST:
		return bmfs_test_read_call(param_types, params);
	case TA_SEEK_FILE_TEST:
		return bmfs_test_seek_call(param_types, params);
	case TA_BMFS_CLEAN:
		return ta_bmfs_cleanup(param_types, params);
*/

	case TA_LIBASMRUN_TEST:
		return libasmrun_test(param_types, params);
	case TA_LIBM_TEST:
		return libm_test_call(param_types, params);
	case ECALL_INC_VAL:
		return inc_value(param_types, params);
	case TA_EMPTY_TEST:
		return empty_test(param_types, params);
	case ECALL_TEST_FROM_TA:
		return pta_test(param_types, params);
	case ECALL_TIME:
		return ecall_time(param_types, params);

	default:
		return TEE_ERROR_BAD_PARAMETERS;
	}
}
