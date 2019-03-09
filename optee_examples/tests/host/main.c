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


#include "ukvm.h"
#include "main.h"
#include "micro_bench.h"





/////////////////////////////////////////ukvm settings////////////////////////////


static void setup_cmdline(char *cmdline, int argc, char **argv)
{
    size_t cmdline_free = UKVM_CMDLINE_SIZE;

    cmdline[0] = 0;

    for (; *argv; argc--, argv++) {
        size_t alen = snprintf(cmdline, cmdline_free, "%s%s", *argv,
                (argc > 1) ? " " : "");
        if (alen >= cmdline_free) {
            errx(1, "Guest command line too long (max=%d characters)",
                    UKVM_CMDLINE_SIZE - 1);
            break;
        }
        cmdline_free -= alen;
        cmdline += alen;
    }
}

static void setup_modules(struct ukvm_hv *hv)
{
    for (struct ukvm_module **m = ukvm_core_modules; *m; m++) {
        assert((*m)->setup);
        if ((*m)->setup(hv)) {
            warnx("Module `%s' setup failed", (*m)->name);
            if ((*m)->usage) {
                warnx("Please check you have correctly specified:\n    %s",
                       (*m)->usage());
            }
            exit(1);
        }
    }
}

static int handle_cmdarg(char *cmdarg)
{
    for (struct ukvm_module **m = ukvm_core_modules; *m; m++) {
        if ((*m)->handle_cmdarg) {
            if ((*m)->handle_cmdarg(cmdarg) == 0) {
                return 0;
            }
        }
    }
    return -1;
}

static void sig_handler(int signo)
{
    errx(1, "Exiting on signal %d", signo);
}

static void handle_mem(char *cmdarg, size_t *mem_size)
{
    size_t mem;
    int rc = sscanf(cmdarg, "--mem=%zd", &mem);
    mem = mem << 20;
    if (rc != 1 || mem <= 0) {
        errx(1, "Malformed argument to --mem");
    }
    *mem_size = mem;
}

static void usage(const char *prog)
{
    fprintf(stderr, "usage: %s [ CORE OPTIONS ] [ MODULE OPTIONS ] [ -- ] "
            "KERNEL [ ARGS ]\n", prog);
    fprintf(stderr, "KERNEL is the filename of the unikernel to run.\n");
    fprintf(stderr, "ARGS are optional arguments passed to the unikernel.\n");
    fprintf(stderr, "Core options:\n");
    fprintf(stderr, "  [ --mem=512 ] (guest memory in MB)\n");
    fprintf(stderr, "    --help (display this help)\n");
    fprintf(stderr, "Compiled-in modules: ");
    for (struct ukvm_module **m = ukvm_core_modules; *m; m++) {
        assert((*m)->name);
        fprintf(stderr, "%s ", (*m)->name);
    }
    fprintf(stderr, "\n");
    fprintf(stderr, "Compiled-in module options:\n");
    int nm = 0;
    for (struct ukvm_module **m = ukvm_core_modules; *m; m++) {
        if ((*m)->usage) {
            fprintf(stderr, "    %s\n", (*m)->usage());
            nm++;
        }
    }
    if (!nm)
        fprintf(stderr, "    (none)\n");
    exit(1);
}



/////////////////////////////////////////ukvm settings////////////////////////////

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




int ukvm_main(int argc, char **argv)
{
	
    tz_test(); // for test only 

    // begin ukvm
    size_t mem_size = 0x10000000;
    ukvm_gpa_t gpa_ep, gpa_kend;
    const char *prog;
    const char *elffile;
    int matched;

    prog = basename(*argv);
    argc--;
    argv++;

    while (*argv && *argv[0] == '-') {
        if (strcmp("--help", *argv) == 0)
            usage(prog);

        if (strcmp("--", *argv) == 0) {
            /* Consume and stop arg processing */
            argc--;
            argv++;
            break;
        }

        matched = 0;
        if (strncmp("--mem=", *argv, 6) == 0) {
            handle_mem(*argv, &mem_size);
            matched = 1;
            argc--;
            argv++;
        }
        if (handle_cmdarg(*argv) == 0) {
            /* Handled by module, consume and go on to next arg */
            matched = 1;
            argc--;
            argv++;
        }
        if (!matched) {
            warnx("Invalid option: `%s'", *argv);
            usage(prog);
        }
    }

    /* At least one non-option argument required */
    if (*argv == NULL) {
        warnx("Missing KERNEL operand");
        usage(prog);
    }
    elffile = *argv;
    argc--;
    argv++;

    struct sigaction sa;
    memset (&sa, 0, sizeof (struct sigaction));
    sa.sa_handler = sig_handler;
    sigfillset(&sa.sa_mask);
    if (sigaction(SIGINT, &sa, NULL) == -1)
        err(1, "Could not install signal handler");
    if (sigaction(SIGTERM, &sa, NULL) == -1)
        err(1, "Could not install signal handler");

    ukvm_hv_mem_size(&mem_size);
    struct ukvm_hv *hv = ukvm_hv_init(mem_size);

    ukvm_elf_load(elffile, hv->mem, hv->mem_size, &gpa_ep, &gpa_kend);

    char *cmdline;
    ukvm_hv_vcpu_init(hv, gpa_ep, gpa_kend, &cmdline);
    setup_cmdline(cmdline, argc, argv);

    setup_modules(hv);

    ukvm_hv_vcpu_loop(hv);

}
//////////////////////////////////////////////////////////////////////////////////






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
