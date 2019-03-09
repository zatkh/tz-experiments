/*
 * Copyright (c) 2016, Linaro Limited
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
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


int tz_test(void)
{

    // TEEC variables

    TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = TA_MINOR_TEST_UUID;
	uint32_t err_origin;


     // init a contex //
	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[TEEC_InitializeContext] failed: 0x%x", res);

	// open a session to TZ //
	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);

	// init TEEC_Operation //
	memset(&op, 0, sizeof(op));

    // set a shared temporary memory refrence

	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INOUT, TEEC_NONE,
					 TEEC_NONE, TEEC_NONE);
	op.params[0].value.a = 100;

	/*
	 * TA_HELLO_WORLD_CMD_INC_VALUE is the actual function in the TA to be
	 * called.
	 */
	printf("Invoking TA to increment %d\n", op.params[0].value.a);
	res = TEEC_InvokeCommand(&sess, TA_HELLO_WORLD_CMD_INC_VALUE, &op,
				 &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);
	printf("TA incremented value to %d\n", op.params[0].value.a);

	// call kvm_init

	/*
	 * We're done with the TA, close the session and
	 * destroy the context.
	 *
	 * The TA will print "Goodbye!" in the log when the
	 * session is closed.
	 */

	TEEC_CloseSession(&sess);

	TEEC_FinalizeContext(&ctx);

	return 0;

}







static void write_test(uint32_t storage_id)
{

    // TEEC variables
	TEEC_Session sess;
    TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Operation op;
	TEEC_UUID uuid = TA_MINOR_TEST_UUID;

	uint32_t err_origin;
    uint32_t obj;
	uint8_t out[10] = { 0 };
	uint32_t count;

    // init a contex //
	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		printf("[write_test] TEEC_InitializeContext failed: 0x%x", res);

	// open a session to TZ //
	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		printf(" [write_test] TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);

	// init TEEC_Operation //
	memset(&op, 0, sizeof(op));
	/* create */
	
	res= fs_create(&sess, file_02, sizeof(file_02),
			  TEE_DATA_FLAG_ACCESS_WRITE, 0, data_01,
			  sizeof(data_01), &obj, storage_id);
    if (res != TEEC_SUCCESS)      
		{	
            printf(" [write_test] fs_create failed with code 0x%x \n", res);
            goto exit;
        }

	res= fs_close(&sess, obj);
    if (res != TEEC_SUCCESS)      
		{	
            printf( " [write_test] fs_close failed with code 0x%x \n", res);
            goto exit;
        }
		

	/* write new data */
	res= fs_open(&sess, file_02, sizeof(file_02),
			TEE_DATA_FLAG_ACCESS_WRITE, &obj, storage_id);
	if (res != TEEC_SUCCESS)      
		{	
            printf( " [write_test] fs_open failed with code 0x%x \n", res);
            goto exit;
        }

	res= fs_write(&sess, obj, data_00, sizeof(data_00));
	if (res != TEEC_SUCCESS)      
		{	
            printf( " [write_test] fs_write failed with code 0x%x \n ", res);
            goto exit;
        }

	res= fs_close(&sess, obj);
	if (res != TEEC_SUCCESS)      
		{	
            printf(" [write_test] fs_close failed with code 0x%x \n", res);
            goto exit;
        }

	/* verify */
    res= fs_open(&sess, file_02, sizeof(file_02),
			TEE_DATA_FLAG_ACCESS_READ |
			TEE_DATA_FLAG_ACCESS_WRITE_META, &obj, storage_id);
	if (res != TEEC_SUCCESS)      
		{	
            printf(" [write_test] fs_open failed with code 0x%x \n ", res);
            goto exit;
        }

	res= fs_read(&sess, obj, out, 10, &count);
	if (res != TEEC_SUCCESS)      
		{	
            printf(" [write_test] fs_read failed with code 0x%x \n", res);
            goto exit;
        }

    if (memcmp(data_00, out,10) != 0)
        printf( " [write_test] not verified \n");

    printf ("YAAAAYYYY");
	/* clean */
	res= fs_unlink(&sess, obj);
	if (res != TEEC_SUCCESS)      
		{	
            printf(" [write_test] fs_unlink failed with code 0x%x \n", res);
            goto exit;
        }

exit:
	TEEC_CloseSession(&sess);
}






TEEC_Result net_test()
{
	TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = TA_NET_UUID;
	uint32_t err_origin;


	printf("[net_test]enter test\n");

	/* Initialize a context connecting us to the TEE */
	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InitializeContext failed with code 0x%x", res);


	printf("[net_test] init\n");

	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);



	memset(&op, 0, sizeof(op));

	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INOUT, TEEC_NONE,
					 TEEC_NONE, TEEC_NONE);
	op.params[0].value.a = 1371;

	res = TEEC_InvokeCommand(&sess, TA_NET_TEST, &op,
				 &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);

	printf("[net_test]TA incremented value to %d\n", op.params[0].value.a);

	TEEC_CloseSession(&sess);

	TEEC_FinalizeContext(&ctx);
}



int main(int argc, char *argv[])
{
	
	TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = TA_MINOR_TEST_UUID;
	uint32_t err_origin,obj;
	uint32_t storage_id=storage_ids[0];
	char buf[]="this is a ecall_puts test";
	size_t len=sizeof(buf);
	char buf_temp[len];

	//tz_test();

	//int fd=ecall_open_bench("enclave.txt");
	//ecall_write_bench( fd, buf,len);
	//lseek(fd, 0, SEEK_SET); 
	//ecall_read_bench(fd,buf_temp, len);
	//printf("buf finally is: %s\n", buf_temp);
	//pta_round_bench();

	ecall_console_bench();
	 //tfs_syscalls_latency();
	 //test_file();
	//ecall_puts_latency(buf_temp,strlen(buf)+1);
	//init_latency();
	//init_latency_seperatly();
	//tfs_latency();

	//hello_file_bench();
	//ecall_hello_fle_bench();

/*
	fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
    {
        printf("Error opening file!\n");
        exit(1);
    }
	

	//printf("storage id: %d\n", storage_ids[1]);
	//write_test(storage_ids[1]);



	time_start = clock();
	for(int i=0;i<ITERATION;i++)
		hello_file_time_bench();
	time_end=clock();

	fprintf(fresult, "[hello_file_time_bench] %f , ITERATION :%d\n", ( (double)(time_end - time_start))/CLOCKS_PER_SEC, ITERATION);

		
	snape_driver_test();


	test_file();

	printf("Invoking net_test \n");

	net_test();

	printf("End of net_test\n");

	
	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InitializeContext failed with code 0x%x", res);

	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);

	
	memset(&op, 0, sizeof(op));

	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INOUT, TEEC_NONE,
					 TEEC_NONE, TEEC_NONE);
	op.params[0].value.a = 1371;


	printf("Invoking TA to increment %d\n", op.params[0].value.a);
	res = TEEC_InvokeCommand(&sess, TA_HELLO_WORLD_CMD_INC_VALUE, &op,
				 &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);
	printf("TA incremented value to %d\n", op.params[0].value.a);

	printf("Invoking BMFS test\n");

	res = TEEC_InvokeCommand(&tfs_sess,ECALL_BMFS_TEST , &op,
				 &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);

/*
 	time_start = clock();
	for(int i=0;i<ITERATION;i++)
		res = TEEC_InvokeCommand(&sess,TA_OPEN_FILE_TEST , &op,
				 &err_origin);
	time_end=clock();

	fprintf(fresult, "SW file open time %f , ITERATION :%d\n", ( (double)(time_end - time_start))/CLOCKS_PER_SEC, ITERATION);


	time_start = clock();
	for(int i=0;i<ITERATION;i++)
		res = TEEC_InvokeCommand(&sess,TA_WRITE_FILE_TEST , &op,&err_origin);
	time_end=clock();

	fprintf(fresult, "SW file write time %f , ITERATION :%d\n", ( (double)(time_end - time_start))/CLOCKS_PER_SEC, ITERATION);

		
	time_start = clock();
	for(int i=0;i<ITERATION;i++)
		res = TEEC_InvokeCommand(&sess,TA_SEEK_FILE_TEST , &op,
				 &err_origin);
	time_end=clock();

	fprintf(fresult, "SW file seek time %f , ITERATION :%d\n", ( (double)(time_end - time_start))/CLOCKS_PER_SEC, ITERATION);

		time_start = clock();
	for(int i=0;i<ITERATION;i++)
		res = TEEC_InvokeCommand(&sess,TA_READ_FILE_TEST , &op,
				 &err_origin);
	time_end=clock();

	fprintf(fresult, "SW file read time %f , ITERATION :%d\n", ( (double)(time_end - time_start))/CLOCKS_PER_SEC, ITERATION);

///////////////////////////////////////////

	memset(&op, 0, sizeof(op));

	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INOUT, TEEC_NONE,
					 TEEC_NONE, TEEC_NONE);

	time_start = clock();
	for(int i=0;i<ITERATION;i++)
		res = TEEC_InvokeCommand(&sess,ECALL_TEST_FROM_TA , &op,
				 &err_origin);
	time_end=clock();

	fprintf(fresult, "ECALL_TEST_FROM_TA %f , ITERATION :%d\n", ( (double)(time_end - time_start))/CLOCKS_PER_SEC, ITERATION);
	
////////////////////////////////////
	res = TEEC_InvokeCommand(&sess,TA_BMFS_CLEAN , &op,
				 &err_origin);
			

	printf("Invoking LIBM test\n");

	res = TEEC_InvokeCommand(&sess, TA_LIBM_TEST, &op,
				 &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);



	TEEC_CloseSession(&sess);

	TEEC_FinalizeContext(&ctx);

   fclose(fresult);
*/
  

	return 0;
}
