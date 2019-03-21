#define _GNU_SOURCE
#include <assert.h>
#include <libgen.h>
#include <signal.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <err.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include<fcntl.h>
#include<errno.h>

#include "main.h"
#include "micro_bench.h"


int hello_ecnalve_test(void)
{

    TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = HELLO_ENCLAVE;
	uint32_t err_origin;
	printf("***********HELLO_ENCLAVE******\n");


     // init a contex //
	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[TEEC_InitializeContext] failed: 0x%x", res);

	// open a session to HELLO_ENCLAVE //
	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);

	// init arguments //
	memset(&op, 0, sizeof(op));
	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INOUT, TEEC_NONE,
					 TEEC_NONE, TEEC_NONE);
	op.params[0].value.a = 100;

	printf("Invoking ECALL_INC_VAL inside HELLO_ENCLAVE to increment %d\n", op.params[0].value.a);
	res = TEEC_InvokeCommand(&sess, ECALL_INC_VAL, &op,
				 &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);
	printf("ECALL_INC_VAL value to %d\n", op.params[0].value.a);

	//memset(&op, 0, sizeof(op));
	res = TEEC_InvokeCommand(&sess, TA_LIBASMRUN_TEST, &op,
				 &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);




	TEEC_CloseSession(&sess);

	TEEC_FinalizeContext(&ctx);

	printf("***********END HELLO_ENCLAVE ! ******\n");

	return 0;

}


static void file_ocalls_test(const char *name)

{

   	TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = TEST_ENCLAVE_UUID;
	uint32_t err_origin;
	char buf[]="this is simple enclave test";
	size_t len=sizeof(buf);
	char temp[len];

	printf("***********TEST_ENCLAVE******\n");

	memset(&op, 0, sizeof(op));
	op.params[0].tmpref.buffer = (void *)name;
	op.params[0].tmpref.size = strlen(name)+1;
	op.paramTypes = TEEC_PARAM_TYPES(TEEC_MEMREF_TEMP_INPUT,TEEC_VALUE_OUTPUT, TEEC_NONE, TEEC_NONE);

// init test enclave ctx
	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[file_ocalls_test] InitializeContext failed with code 0x%x", res);

// open test enclave ssession

	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[file_ocalls_test] Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);

// invoke O_OPEN call inside enclave
	res = TEEC_InvokeCommand(&sess,O_OPEN , &op,&err_origin);
	int fd=op.params[1].value.a;;

// invoke O_WRITE call inside enclave

	memset(&op, 0, sizeof(op));
	op.params[0].value.a=fd;
	op.params[1].tmpref.buffer = buf;
	op.params[1].tmpref.size = len;
	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INPUT,TEEC_MEMREF_TEMP_INPUT,TEEC_VALUE_OUTPUT, TEEC_NONE);

	res = TEEC_InvokeCommand(&sess, O_WRITE , &op,&err_origin);

// SEEK_SET 
	lseek(fd, 0, SEEK_SET); 

// invoke O_READ call inside enclave


	memset(&op, 0, sizeof(op));
	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INPUT,TEEC_MEMREF_TEMP_OUTPUT,TEEC_VALUE_INPUT, TEEC_MEMREF_TEMP_OUTPUT);
	op.params[0].value.a=fd;
	op.params[2].value.a=len;
	op.params[3].tmpref.buffer = temp;
	op.params[3].tmpref.size = sizeof(temp);

	res = TEEC_InvokeCommand(&sess, O_READ, &op,&err_origin);
	memcpy( buf,temp, op.params[3].tmpref.size);


	if (res != TEEC_SUCCESS)
		errx(1, "[file_ocalls_test]TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);

	printf("[file_ocalls_test]read_buf finally is: %s\n", temp);


	TEEC_CloseSession(&sess);

	TEEC_FinalizeContext(&ctx);

	printf("***********END TEST_ENCLAVE******\n");


}



int main(int argc, char *argv[])
{

	uint32_t err_origin,obj;
	uint32_t storage_id=storage_ids[0];
	char buf[]="this is simple enclave test";
	size_t len=sizeof(buf);
	char buf_temp[len];

/****************************HELLO_ENCLAVE: test***********************/
	hello_ecnalve_test();



/******************************TEST_ENCLAVE: file ocalls/rpcs test********************/
// check enclave rpc to access file operations in NW
	file_ocalls_test("enclave.txt");

// check enclave rpc to access file operations in NW -- seperatly
	//int fd=ecall_open_bench("enclave.txt");
	//	ecall_write_bench( fd, buf,len);
	//	lseek(fd, 0, SEEK_SET); 
	//	ecall_read_bench(fd,buf_temp, len);
	//	printf("read_buf finally is: %s\n", buf_temp);

  
	return 0;
}
