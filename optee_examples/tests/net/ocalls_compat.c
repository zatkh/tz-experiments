
#include <net_enclave.h>
#include <stdlib.h>
#include "ocalls_compat.h"

TEE_TASessionHandle sess;
const TEE_UUID core_uuid = SNAPE_DRIVER_UUID;

TEE_Result snape_driver_open()
					
{

	TEE_Result res;
	uint32_t err_origin;
	
	res = TEE_OpenTASession(&core_uuid, 0, 0, NULL, &sess, NULL);
		if (res != TEE_SUCCESS)
	    printf("[snape_driver_open] failed\n");
    return res;

}


void snape_driver_close()
					
{
	TEE_CloseTASession(sess);

}

int close(int fd)
{
    TEE_Result res;
	uint32_t err_origin;
	TEE_Param params[TEE_NUM_PARAMS];
	uint32_t param_types;

	param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_VALUE_INOUT,
				      TEE_PARAM_TYPE_NONE,
				      TEE_PARAM_TYPE_NONE,
				      TEE_PARAM_TYPE_NONE);
	memset(params, 0, sizeof(params));
	params[0].value.a = fd;
  snape_driver_open();

	res = TEE_InvokeTACommand(sess, 0, O_CLOSE, param_types, params, &err_origin);
	if (res != TEE_SUCCESS)
	    {
			printf("[ocall_close] failed\n");
			return -1;
		}

  snape_driver_close();

	return 0;

}
int tap_open(const char *name)
{
    TEE_Result res;
	uint32_t err_origin;
	void* buf;
	TEE_Param params[TEE_NUM_PARAMS];
	uint32_t param_types;

	param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_MEMREF_INPUT,
				      TEE_PARAM_TYPE_VALUE_OUTPUT,
				      TEE_PARAM_TYPE_NONE,
				      TEE_PARAM_TYPE_NONE);
	memset(params, 0, sizeof(params));
	
	params[0].memref.buffer=(void *)name;
	params[0].memref.size= strlen(name)+1;
	//printf("[tap_open]name: %s\n",name);
  snape_driver_open();
	res = TEE_InvokeTACommand(sess, 0, O_TAP_OPEN, param_types, params, &err_origin);
	if (res != TEE_SUCCESS)
	    {
			printf("[tap_open] failed\n");
			return -1;
		}
  snape_driver_close();
	int fd=params[1].value.a;
	//	printf("[tap_open] fd %d\n",fd );

	return fd;

}

/*
ssize_t read(int, void *, size_t)
{
    TEE_Result res;
	uint32_t err_origin;
	TEE_Param params[TEE_NUM_PARAMS];
	uint32_t param_types;

	param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_VALUE_INOUT,
				      TEE_PARAM_TYPE_NONE,
				      TEE_PARAM_TYPE_NONE,
				      TEE_PARAM_TYPE_NONE);
	memset(params, 0, sizeof(params));
	params[0].value.a = fd;

	res = TEE_InvokeTACommand(sess, 0, O_CLOSE, param_types, params, &err_origin);
	if (res != TEE_SUCCESS)
	    {
			printf("[ocall_close] failed\n");
			return -1;
		}


	return 0;

}



ssize_t write(int, const void *, size_t)
{
    TEE_Result res;
	uint32_t err_origin;
	TEE_Param params[TEE_NUM_PARAMS];
	uint32_t param_types;

	param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_VALUE_INOUT,
				      TEE_PARAM_TYPE_NONE,
				      TEE_PARAM_TYPE_NONE,
				      TEE_PARAM_TYPE_NONE);
	memset(params, 0, sizeof(params));
	params[0].value.a = fd;

	res = TEE_InvokeTACommand(sess, 0, O_CLOSE, param_types, params, &err_origin);
	if (res != TEE_SUCCESS)
	    {
			printf("[ocall_close] failed\n");
			return -1;
		}


	return 0;

}
*/


int usleep(int micorsec)
{
	
    TEE_Result res;
	uint32_t err_origin;
	TEE_Param params[TEE_NUM_PARAMS];
	uint32_t param_types;

	param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_VALUE_INOUT,
				      TEE_PARAM_TYPE_NONE,
				      TEE_PARAM_TYPE_NONE,
				      TEE_PARAM_TYPE_NONE);
	memset(params, 0, sizeof(params));
	params[0].value.a = micorsec;

  
 snape_driver_open();
	res = TEE_InvokeTACommand(sess, 0, USLEEP, param_types, params, &err_origin);
	if (res != TEE_SUCCESS)
	    printf("[ocall_usleep] failed\n");
 snape_driver_close();
  
	return res;

}
