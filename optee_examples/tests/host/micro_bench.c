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


#define _1_SEC_TO_NS 1000000000
#define ITERATION 100
FILE *fresult;



static TEEC_Session tfs_sess,tcrypt_sess,tui_sess,tnet_sess,ta_sess;
static TEEC_Context tfs_ctx,tcrypt_ctx,tui_ctx,tnet_ctx,ta_ctx;
static TEEC_UUID ta_uuid= TA_MINOR_TEST_UUID;
static TEEC_UUID tfs_uuid=TFS_UUID;
static TEEC_UUID tnet_uuid=TA_NET_UUID;
static TEEC_UUID tcrypt_uuid=TCRYPTO_UUID;
static TEEC_UUID tui_uuid=TUI_UUID;


static unsigned long diff_time(struct timespec * op1, struct timespec * op2){
  return (op1->tv_sec - op2->tv_sec)*_1_SEC_TO_NS + op1->tv_nsec - op2->tv_nsec;
}


static TEEC_Result init_enclaves(void)
{

    TEEC_Result res;


	uint32_t err_origin;

	
	// init tfs enclave//
	res = TEEC_InitializeContext(NULL, &tfs_ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] tfs-enclave failed: 0x%x", res);


	res = TEEC_OpenSession(&tfs_ctx, &tfs_sess, &tfs_uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] open tfs-enclave failed with code 0x%x origin 0x%x",
			res, err_origin);

  	// end tfs enclave//

     // init main enclave//
	res = TEEC_InitializeContext(NULL, &ta_ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] main-enclave failed: 0x%x", res);


	res = TEEC_OpenSession(&ta_ctx, &ta_sess, &ta_uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] open main-enclave failed with code 0x%x origin 0x%x",
			res, err_origin);


  	// end main enclave//

	// init net enclave//
	res = TEEC_InitializeContext(NULL, &tnet_ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] net-enclave failed: 0x%x", res);


	res = TEEC_OpenSession(&tnet_ctx, &tnet_sess, &tnet_uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] open net-enclave failed with code 0x%x origin 0x%x",
			res, err_origin);


  	// end net enclave//


	// init crypto enclave//
	res = TEEC_InitializeContext(NULL, &tcrypt_ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] crypto-enclave failed: 0x%x", res);


	res = TEEC_OpenSession(&tcrypt_ctx, &tcrypt_sess, &tcrypt_uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] open crypto-enclave failed with code 0x%x origin 0x%x",
			res, err_origin);


  	// end crypto enclave//


	// init tui enclave//
	res = TEEC_InitializeContext(NULL, &tui_ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] tui-enclave failed: 0x%x", res);


	res = TEEC_OpenSession(&tui_ctx, &tui_sess, &tui_uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[init_enclaves] open tui-enclave failed with code 0x%x origin 0x%x",
			res, err_origin);


  	// end tui enclave//

	  return res;
   
}



static void destroy_enclaves(void)
{

	// close open sessions and contexes
	TEEC_CloseSession(&tfs_sess);
	TEEC_FinalizeContext(&tfs_ctx);

	TEEC_CloseSession(&ta_sess);
	TEEC_FinalizeContext(&ta_ctx);

	TEEC_CloseSession(&tnet_sess);
	TEEC_FinalizeContext(&tnet_ctx);

	TEEC_CloseSession(&tcrypt_sess);
	TEEC_FinalizeContext(&tcrypt_ctx);

	TEEC_CloseSession(&tui_sess);
	TEEC_FinalizeContext(&tui_ctx);

	
	

   
}

void init_latency(void)
{
    	
	TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = TA_MINOR_TEST_UUID;
	uint32_t err_origin,obj;
	uint32_t storage_id=storage_ids[0];
	unsigned long diff = 0;
	struct timespec init_second, current_time;
	struct timespec * init_secondp = &init_second, \
                  * current_timep = &current_time;

	fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
    {
        printf("Error opening file!\n");
        exit(1);
    }
	

	for(int i=0;i<ITERATION;i++)
{
	clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
	res= init_enclaves();
	if (res != TEEC_SUCCESS)
		printf("init enclaves faild\n");
   	destroy_enclaves();
	clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
    // calculate how much time passed
    diff = diff_time(current_timep, init_secondp);

	fprintf(fresult, "[micro-bench] total init latency for itertaion number [%d] :%ld\n", i,diff);
}

    fclose(fresult);
}

void init_latency_seperatly(void)
{
    	
	TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = TA_MINOR_TEST_UUID;
	uint32_t err_origin,obj;
	uint32_t storage_id=storage_ids[0];
	unsigned long diff = 0;
	struct timespec init_second, current_time;
	struct timespec * init_secondp = &init_second, \
                  * current_timep = &current_time;

	fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
    {
        printf("Error opening file!\n");
        exit(1);
    }
	

	for(int i=0;i<ITERATION;i++)
{
	clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
	res= init_enclaves();
	if (res != TEEC_SUCCESS)
		printf("init enclaves faild\n");
    clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
    
    diff = diff_time(current_timep, init_secondp);
    fprintf(fresult, "[micro-bench] init enclaves latency for itertaion number [%d] :%ld\n", i,diff);

    clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
   	destroy_enclaves();
	clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
    // calculate how much time passed
    diff = diff_time(current_timep, init_secondp);

	fprintf(fresult, "[micro-bench] destroy enclaves latency for itertaion number [%d] :%ld\n", i,diff);
}

    fclose(fresult);
}


void tfs_latency(void)
{
        TEEC_Operation op;
        uint32_t err_origin;
        TEEC_Result res;
        unsigned long diff = 0;
        struct timespec init_second, current_time;
        struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;
		
		TEEC_Session tfs_sess_temp;
		TEEC_Context tfs_ctx_temp;
	    TEEC_UUID tfs_uuid_temp=TFS_UUID;

	// init tfs enclave//
	res = TEEC_InitializeContext(NULL, &tfs_ctx_temp);
	if (res != TEEC_SUCCESS)
		errx(1, "[tfs_latency] tfs-enclave failed: 0x%x", res);


	res = TEEC_OpenSession(&tfs_ctx_temp, &tfs_sess_temp, &tfs_uuid_temp,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[tfs_latency] open tfs-enclave failed with code 0x%x origin 0x%x",
			res, err_origin);


    fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }
        memset(&op, 0, sizeof(op));
	    op.paramTypes = TEEC_PARAM_TYPES(TEEC_NONE, TEEC_NONE,
					 TEEC_NONE, TEEC_NONE);
	    //op.params[0].value.a = 1371; 


	for(int i=0;i<1;i++)
{
        clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);

	    res = TEEC_InvokeCommand(&tfs_sess_temp,ECALL_BMFS_TEST , &op,
				 &err_origin);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

	    if (res != TEEC_SUCCESS)
	    	errx(1, "[tfs_latency]TEEC_InvokeCommand failed with code 0x%x origin 0x%x",res, err_origin);

        
        diff = diff_time(current_timep, init_secondp);
        fprintf(fresult, "[micro-bench] init enclaves latency for itertaion number [%d] :%ld\n", i,diff);



}


	TEEC_CloseSession(&tfs_sess_temp);
	TEEC_FinalizeContext(&tfs_ctx_temp);
	fclose(fresult);  



}


void ecall_puts_latency(void* buf, size_t buf_len)
{

    TEEC_Operation op;
    uint32_t err_origin;
    TEEC_Result res;
	unsigned long diff = 0;
	unsigned long avg = 0;
    struct timespec init_second, current_time;
    struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;
					 
	char buffer[buf_len];
    fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }

	memset(&op, 0, sizeof(op));
//	memcpy(op.params[0].tmpref.buffer,(void *)p->data ,p->len);
	op.params[0].tmpref.buffer = buf;
	op.params[0].tmpref.size = buf_len;

	printf("[ecall_puts_latency] buf :%s, len %d \n",(char*) buf,buf_len);


	op.paramTypes = TEEC_PARAM_TYPES(TEEC_MEMREF_TEMP_INPUT,TEEC_NONE, TEEC_NONE, TEEC_NONE);


	
	res = TEEC_InitializeContext(NULL, &tui_ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_puts_latency] tui-enclave failed: 0x%x", res);


	res = TEEC_OpenSession(&tui_ctx, &tui_sess, &tui_uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_puts_latency] open tui-enclave failed with code 0x%x origin 0x%x",
			res, err_origin);

	for(int i=0;i<ITERATION;i++){
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
	 
   		snprintf(buffer,buf_len, "%s\n",( char *)buf); 
    	printf("%s\n", buffer); 
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
		diff = diff_time(current_timep, init_secondp);
		avg += diff;
    	fprintf(fresult, "[micro-bench] puts_latency for itertaion number [%d] :%ld\n", i,diff);  
	}  			
		fprintf(fresult, "[micro-bench] puts_latency average :%ld\n",(unsigned long)(avg/ITERATION));
 
avg=0;
	for(int i=0;i<ITERATION;i++){
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
		res = TEEC_InvokeCommand(&tui_sess, ECALL_PUTS, &op,&err_origin);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

		if (res != TEEC_SUCCESS)
			errx(1, "[ecall_puts_latency] failed with code 0x%x origin 0x%x",
				res, err_origin);
		
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
		diff = diff_time(current_timep, init_secondp);
		avg += diff;
    	fprintf(fresult, "[micro-bench] ecall_puts_latency for itertaion number [%d] :%ld\n", i,diff);

      
	}  

		fprintf(fresult, "[micro-bench] ecall_puts_latency average :%ld\n",(unsigned long)(avg/ITERATION)); 
     


	TEEC_CloseSession(&tui_sess);
	TEEC_FinalizeContext(&tui_ctx);
	fclose(fresult); 

}


static int hello_file_time_bench(void)
{

    int fd;
    char buf1[12] = "hello world";
    char buf2[12];
 
    // assume foobar.txt is already created
    fd = open("foobar.txt", O_RDWR | O_CREAT);             
    write(fd, buf1, strlen(buf1)); 
	lseek(fd, 0, SEEK_SET); 
	read(fd, buf2, sizeof(buf2));       
 	printf("[hello_file_time_bench] %s\n",buf2);
    close(fd);
 	
    return 0;

}

void hello_file_bench(void)
{
	unsigned long diff = 0;
	unsigned long avg = 0;
    struct timespec init_second, current_time;
    struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;
					 
    fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }


	for(int i=0;i<ITERATION;i++)
{
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
		hello_file_time_bench();
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
		diff = diff_time(current_timep, init_secondp);
		avg += diff;		
    	//fprintf(fresult, "[micro-bench] hello_file_bench for itertaion number [%d] :%ld\n", i,diff);

}	

	fprintf(fresult, "[micro-bench] hello_file_bench average :%ld\n",(unsigned long)(avg/ITERATION)); 
     
	fclose(fresult); 
}


void ecall_hello_fle_bench(void)
{
	TEEC_Operation op;
    uint32_t err_origin;
    TEEC_Result res;
	unsigned long diff = 0;
	unsigned long avg = 0;
    struct timespec init_second, current_time;
    struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;
					 

    fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }

	memset(&op, 0, sizeof(op));

	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INOUT, TEEC_NONE,TEEC_NONE, TEEC_NONE);
	op.params[0].value.a = 100;
	res = TEEC_InitializeContext(NULL, &ta_ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_hello_fle_bench] main-enclave failed: 0x%x", res);


	res = TEEC_OpenSession(&ta_ctx, &ta_sess, &ta_uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_hello_fle_bench] open main-enclave failed with code 0x%x origin 0x%x",
			res, err_origin);

	for(int i=0;i<ITERATION;i++){
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
   		res = TEEC_InvokeCommand(&ta_sess, ECALL_TEST_FROM_TA, &op,&err_origin);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

		if (res != TEEC_SUCCESS)
			errx(1, "[ecall_puts_latency] failed with code 0x%x origin 0x%x",
				res, err_origin);
		diff = diff_time(current_timep, init_secondp);
		avg += diff;
    	//fprintf(fresult, "[micro-bench] ecall_hello_fle_benchfor itertaion number [%d] :%ld\n", i,diff);  
	}  			
		fprintf(fresult, "[micro-bench] ecall_hello_fle_bench average :%ld\n",(unsigned long)(avg/ITERATION));
 
	

	TEEC_CloseSession(&ta_sess);
	TEEC_FinalizeContext(&ta_ctx);
	fclose(fresult); 

}



void tee_pta_test(int val)

{

val ++;
printf("[ecall_test] %d\n",val);
printf("from enclave: ecall_test successfull \n");

}

void pta_round_bench(void)
{
	TEEC_Operation op;
    uint32_t err_origin;
    TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_UUID uuid = SNAPE_DRIVER_UUID;
	unsigned long diff = 0;
	unsigned long avg = 0;
    struct timespec init_second, current_time;
    struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;

   fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }

	printf("[ecall_console_bench]enter \n");

	/* Initialize a context connecting us to the TEE */
	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_console_bench]TEEC_InitializeContext failed with code 0x%x", res);


	printf("[ecall_console_bench] init\n");

	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_console_bench]TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);


	memset(&op, 0, sizeof(op));

	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INOUT, TEEC_NONE,TEEC_NONE, TEEC_NONE);
	op.params[0].value.a = 100;
	
	for(int i=0;i<ITERATION;i++){
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
   		res = TEEC_InvokeCommand(&sess, ECALL_TEST, &op,&err_origin);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

		if (res != TEEC_SUCCESS)
			errx(1, "[ecall_puts_latency] failed with code 0x%x origin 0x%x",
				res, err_origin);
		diff = diff_time(current_timep, init_secondp);
		avg += diff;
    	//fprintf(fresult, "[micro-bench] ecall_hello_fle_benchfor itertaion number [%d] :%ld\n", i,diff);  
	} 
			fprintf(fresult, "[micro-bench] pta_round_bench pta average :%ld\n",(unsigned long)(avg/ITERATION));
 
	avg=0;
	for(int i=0;i<ITERATION;i++){
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
		tee_pta_test(100);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
		diff = diff_time(current_timep, init_secondp);
		avg += diff;
    	//fprintf(fresult, "[micro-bench] ecall_hello_fle_benchfor itertaion number [%d] :%ld\n", i,diff);  
	}  			

		fprintf(fresult, "[micro-bench] pta_round_bench normal average :%ld\n",(unsigned long)(avg/ITERATION));
 
	

	TEEC_CloseSession(&sess);
	TEEC_FinalizeContext(&ctx);
	fclose(fresult); 

}





void ecall_console_bench(void)
{
	TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = SNAPE_DRIVER_UUID;
	uint32_t err_origin;
	unsigned long diff = 0;
	unsigned long avg = 0;
    struct timespec init_second, current_time;
    struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;

   fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }

	printf("[ecall_console_bench]enter \n");

	/* Initialize a context connecting us to the TEE */
	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_console_bench]TEEC_InitializeContext failed with code 0x%x", res);


	printf("[ecall_console_bench] init\n");

	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_console_bench]TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);



	memset(&op, 0, sizeof(op));

	op.paramTypes = TEEC_PARAM_TYPES(TEEC_NONE, TEEC_NONE,TEEC_NONE, TEEC_NONE);

	
	res = TEEC_InvokeCommand(&sess, ENCLAVE_CONSOLE_TEST , &op,
				 &err_origin);



	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_console_bench]TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);




	TEEC_CloseSession(&sess);

	TEEC_FinalizeContext(&ctx);
	fclose(fresult); 

}


int ecall_open_bench(const char *name)
{
   	TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = SNAPE_DRIVER_UUID;
	uint32_t err_origin;
	unsigned long diff = 0;
	unsigned long avg = 0;
    struct timespec init_second, current_time;
    struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;

   fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }

	memset(&op, 0, sizeof(op));
	op.params[0].tmpref.buffer = (void *)name;
	op.params[0].tmpref.size = strlen(name)+1;
	op.paramTypes = TEEC_PARAM_TYPES(TEEC_MEMREF_TEMP_INPUT,TEEC_VALUE_OUTPUT, TEEC_NONE, TEEC_NONE);


	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_open_bench]TEEC_InitializeContext failed with code 0x%x", res);


	printf("[ecall_open_bench] init\n");

	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_open_bench]TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);


	res = TEEC_InvokeCommand(&sess,O_OPEN , &op,&err_origin);



	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_console_bench]TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);

	int fd=op.params[1].value.a;;
	printf("[ecall_console_bench] fd %d\n",fd );

	TEEC_CloseSession(&sess);

	TEEC_FinalizeContext(&ctx);
	fclose(fresult); 

	return fd;

}


int ecall_write_bench(int fd, void * buf, size_t len)
{
   	TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = SNAPE_DRIVER_UUID;
	uint32_t err_origin;
	unsigned long diff = 0;
	unsigned long avg = 0;
    struct timespec init_second, current_time;
    struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;

   fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }

	memset(&op, 0, sizeof(op));
	op.params[0].value.a=fd;

	op.params[1].tmpref.buffer = buf;
	op.params[1].tmpref.size = len;

	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INPUT,TEEC_MEMREF_TEMP_INPUT,TEEC_VALUE_OUTPUT, TEEC_NONE);


	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_write_bench]TEEC_InitializeContext failed with code 0x%x", res);


	printf("[ecall_write_bench] init\n");

	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_write_bench]TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);


	res = TEEC_InvokeCommand(&sess, O_WRITE , &op,&err_origin);



	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_write_bench]TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);

	int written_len=op.params[2].value.a;
	printf("[ecall_write_bench] written_len %d\n",written_len );

	TEEC_CloseSession(&sess);

	TEEC_FinalizeContext(&ctx);
	fclose(fresult); 

}


int ecall_read_bench(int fd, void * buf, size_t len)
{
   	TEEC_Result res;
	TEEC_Context ctx;
	TEEC_Session sess;
	TEEC_Operation op;
	TEEC_UUID uuid = SNAPE_DRIVER_UUID;
	uint32_t err_origin;
	unsigned long diff = 0;
	unsigned long avg = 0;
    struct timespec init_second, current_time;
    struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;

	char temp[len];
   fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }

	memset(&op, 0, sizeof(op));
	op.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INPUT,TEEC_MEMREF_TEMP_OUTPUT,TEEC_VALUE_INPUT, TEEC_MEMREF_TEMP_OUTPUT);

	op.params[0].value.a=fd;
	op.params[2].value.a=len;
	op.params[3].tmpref.buffer = temp;
	op.params[3].tmpref.size = sizeof(temp);


	res = TEEC_InitializeContext(NULL, &ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_read_bench]TEEC_InitializeContext failed with code 0x%x", res);


	printf("[ecall_read_bench] init\n");

	res = TEEC_OpenSession(&ctx, &sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_read_bench]TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, err_origin);


	res = TEEC_InvokeCommand(&sess, O_READ, &op,&err_origin);

	if (res != TEEC_SUCCESS)
		errx(1, "[ecall_read_bench]TEEC_InvokeCommand failed with code 0x%x origin 0x%x",
			res, err_origin);

	memcpy( buf,temp, op.params[3].tmpref.size);

	TEEC_CloseSession(&sess);

	TEEC_FinalizeContext(&ctx);
	fclose(fresult); 

	return op.params[1].tmpref.size;

}

void tfs_syscalls_latency(void)
{
        TEEC_Operation op;
        uint32_t err_origin;
        TEEC_Result res;
        unsigned long diff = 0;
		unsigned long avg = 0;
        struct timespec init_second, current_time;
        struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;
		
		TEEC_Session tfs_sess_temp;
		TEEC_Context tfs_ctx_temp;
	    TEEC_UUID tfs_uuid_temp=TFS_UUID;

	// init tfs enclave//
	res = TEEC_InitializeContext(NULL, &tfs_ctx_temp);
	if (res != TEEC_SUCCESS)
		errx(1, "[tfs_syscalls_latency] tfs-enclave failed: 0x%x", res);


	res = TEEC_OpenSession(&tfs_ctx_temp, &tfs_sess_temp, &tfs_uuid_temp,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &err_origin);
	if (res != TEEC_SUCCESS)
		errx(1, "[tfs_syscalls_latency] open tfs-enclave failed with code 0x%x origin 0x%x",
			res, err_origin);


    fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }
        memset(&op, 0, sizeof(op));
	    op.paramTypes = TEEC_PARAM_TYPES(TEEC_NONE, TEEC_NONE,
					 TEEC_NONE, TEEC_NONE);
	    //op.params[0].value.a = 1371; 

		fprintf(fresult, "[micro-bench] ***********tfs_syscalls_latency*************\n");

// ECALL_INIT_PRIVATE_FILE
        clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);

	    res = TEEC_InvokeCommand(&tfs_sess_temp,ECALL_INIT_PRIVATE_FILE , &op,
				 &err_origin);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

	    if (res != TEEC_SUCCESS)
	    	errx(1, "[tfs_syscalls_latency]TEEC_InvokeCommand ECALL_INIT_PRIVATE_FILE failed with code 0x%x origin 0x%x",res, err_origin);

        
        diff = diff_time(current_timep, init_secondp);
        fprintf(fresult, "[micro-bench] ECALL_INIT_PRIVATE_FILE latency :%ld\n", diff);

//ECALL_CREATE
        clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);

	    res = TEEC_InvokeCommand(&tfs_sess_temp,ECALL_CREATE , &op,
				 &err_origin);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

	    if (res != TEEC_SUCCESS)
	    	errx(1, "[tfs_syscalls_latency]TEEC_InvokeCommand ECALL_CREATE failed with code 0x%x origin 0x%x",res, err_origin);

       
        diff = diff_time(current_timep, init_secondp);
        fprintf(fresult, "[micro-bench] ECALL_CREATE latency :%ld\n", diff);

				




//ECALL_OPEN
		for(int i=0;i<ITERATION;i++)
		{	
			clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);

			res = TEEC_InvokeCommand(&tfs_sess_temp,ECALL_OPEN , &op,
					&err_origin);
			clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

			if (res != TEEC_SUCCESS)
				errx(1, "[tfs_syscalls_latency]TEEC_InvokeCommand ECALL_OPEN failed with code 0x%x origin 0x%x",res, err_origin);

			
			diff = diff_time(current_timep, init_secondp);
			avg +=diff;
		//	fprintf(fresult, "[micro-bench] ECALL_OPEN latency :%ld\n", diff);
		}
		fprintf(fresult, "[micro-bench] ECALL_OPEN average :%ld\n",(unsigned long)(avg/ITERATION));

//ECALL_WRITE
		avg=0;
		for(int i=0;i<ITERATION;i++)
		{
			clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);

			res = TEEC_InvokeCommand(&tfs_sess_temp,ECALL_WRITE , &op,
					&err_origin);
			clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

			if (res != TEEC_SUCCESS)
				errx(1, "[tfs_syscalls_latency]TEEC_InvokeCommand ECALL_WRITE failed with code 0x%x origin 0x%x",res, err_origin);

			
			diff = diff_time(current_timep, init_secondp);
			avg +=diff;
		//	fprintf(fresult, "[micro-bench] ECALL_WRITE latency :%ld\n", diff);
		}	
		fprintf(fresult, "[micro-bench] ECALL_WRITE average :%ld\n",(unsigned long)(avg/ITERATION));



//ECALL_SEEK
		avg=0;
		for(int i=0;i<ITERATION;i++)
		{
			clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);

			res = TEEC_InvokeCommand(&tfs_sess_temp,ECALL_SEEK , &op,
					&err_origin);
			clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

			if (res != TEEC_SUCCESS)
				errx(1, "[tfs_syscalls_latency]TEEC_InvokeCommand ECALL_SEEK failed with code 0x%x origin 0x%x",res, err_origin);

			
			diff = diff_time(current_timep, init_secondp);
			avg +=diff;
		//	fprintf(fresult, "[micro-bench] ECALL_SEEK latency :%ld\n", diff);
		}

		fprintf(fresult, "[micro-bench] ECALL_SEEK average :%ld\n",(unsigned long)(avg/ITERATION));


//ECALL_READ
		avg=0;
		for(int i=0;i<ITERATION;i++)
		{
			clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);

			res = TEEC_InvokeCommand(&tfs_sess_temp,ECALL_READ , &op,
					&err_origin);
			clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

			if (res != TEEC_SUCCESS)
				errx(1, "[tfs_syscalls_latency]TEEC_InvokeCommand ECALL_READ failed with code 0x%x origin 0x%x",res, err_origin);

			
			diff = diff_time(current_timep, init_secondp);
			avg +=diff;
			//fprintf(fresult, "[micro-bench] ECALL_READ latency :%ld\n", diff);
		}
		fprintf(fresult, "[micro-bench] ECALL_READ average :%ld\n",(unsigned long)(avg/ITERATION));

//ECALL_CLOSE
		avg=0;
		for(int i=0;i<ITERATION;i++)
		{
			clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);

			res = TEEC_InvokeCommand(&tfs_sess_temp,ECALL_CLOSE , &op,
					&err_origin);
			clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

			if (res != TEEC_SUCCESS)
				errx(1, "[tfs_syscalls_latency]TEEC_InvokeCommand ECALL_CLOSE failed with code 0x%x origin 0x%x",res, err_origin);

			
			diff = diff_time(current_timep, init_secondp);
			avg +=diff;
			//fprintf(fresult, "[micro-bench] ECALL_CLOSE latency :%ld\n", diff);
		}
		fprintf(fresult, "[micro-bench] ECALL_READ average :%ld\n",(unsigned long)(avg/ITERATION));

//ECALL_BMFS_CLEAN
        clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);

	    res = TEEC_InvokeCommand(&tfs_sess_temp,ECALL_BMFS_CLEAN , &op,
				 &err_origin);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);

	    if (res != TEEC_SUCCESS)
	    	errx(1, "[tfs_syscalls_latency]TEEC_InvokeCommand ECALL_BMFS_CLEAN failed with code 0x%x origin 0x%x",res, err_origin);

        
        diff = diff_time(current_timep, init_secondp);
        fprintf(fresult, "[micro-bench] ECALL_BMFS_CLEAN latency :%ld\n", diff);






	TEEC_CloseSession(&tfs_sess_temp);
	TEEC_FinalizeContext(&tfs_ctx_temp);
	fclose(fresult);  



}



void test_file (void) {

   	const char c[] = "this is a fucking test";
	size_t len= strlen(c);   
   	char buffer[len];
  	unsigned long diff = 0;
	unsigned long avg = 0;
	int fd;
    struct timespec init_second, current_time;
    struct timespec * init_secondp = &init_second, \
                        * current_timep = &current_time;
					 
    fresult = fopen("results.txt", "ab+");
    if (fresult == NULL)
        {
            printf("Error opening file!\n");
            exit(1);
        }
 	
	fprintf(fresult, "[micro-bench] ***********test_file*************\n");

//open
	for(int i=0;i<ITERATION;i++)
	{	
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
		fd=open("foobar.txt", O_RDWR | O_CREAT);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
		diff = diff_time(current_timep, init_secondp);
		avg +=diff;
		//	fprintf(fresult, "[micro-bench] open latency :%ld\n", diff);
	}
		fprintf(fresult, "[micro-bench] open average :%ld\n",(unsigned long)(avg/ITERATION));

//write
	avg=0;
	for(int i=0;i<ITERATION;i++)
	{	
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
		write(fd, c, strlen(c)); 
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
		diff = diff_time(current_timep, init_secondp);
		avg +=diff;
		//	fprintf(fresult, "[micro-bench] open latency :%ld\n", diff);
	}
		fprintf(fresult, "[micro-bench] write average :%ld\n",(unsigned long)(avg/ITERATION));

//seek
	avg=0;
	for(int i=0;i<ITERATION;i++)
	{	
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
		lseek(fd, 0, SEEK_SET); 
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep);
		diff = diff_time(current_timep, init_secondp);
		avg +=diff;
		//	fprintf(fresult, "[micro-bench] open latency :%ld\n", diff);
	}
		fprintf(fresult, "[micro-bench] seek average :%ld\n",(unsigned long)(avg/ITERATION));

//read
	avg=0;
	for(int i=0;i<ITERATION;i++)
	{	
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
		read(fd, buffer, len); 
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep); 
		//printf("[test_file] %s\n",buffer);
		diff = diff_time(current_timep, init_secondp);
		avg +=diff;
		//	fprintf(fresult, "[micro-bench] open latency :%ld\n", diff);
	}
		fprintf(fresult, "[micro-bench] read average :%ld\n",(unsigned long)(avg/ITERATION));

//close
	avg=0;
	for(int i=0;i<ITERATION;i++)
	{	
		clock_gettime(CLOCK_MONOTONIC_RAW, init_secondp);
		close(fd);
		clock_gettime(CLOCK_MONOTONIC_RAW, current_timep); 
		diff = diff_time(current_timep, init_secondp);
		avg +=diff;
		//	fprintf(fresult, "[micro-bench] open latency :%ld\n", diff);
	}
		fprintf(fresult, "[micro-bench] close average :%ld\n",(unsigned long)(avg/ITERATION));


   fclose(fresult); 

}




