

#include <tee_internal_api.h>
#include <tee_internal_api_extensions.h>


#include <stdlib.h>
#include "net_enclave.h"
#include "ocalls_compat.h"

#include <time.h>
#include <pico_stack.h>
#include <pico_ipv4.h>
#include <pico_icmp4.h>
#include <pico_dev_tap.h>

#define NUM_PING 10

static int finished = 0;

void cb_ping(struct pico_icmp4_stats *s)
{
    char host[30];
    pico_ipv4_to_string(host, s->dst.addr);
    if (s->err == 0) {
        printf("%lu bytes from %s: icmp_req=%lu ttl=%lu time=%lu ms\n", s->size,
                host, s->seq, s->ttl, (long unsigned int)s->time);
        if (s->seq >= NUM_PING)
            finished = 1;
    } else {
        printf("PING %lu to %s: Error %d\n", s->seq, host, s->err);
        finished = 1;
    }
}



int ping_test(void){
    int id;
    struct pico_ip4 ipaddr, netmask;
    struct pico_device* dev;

    pico_stack_init();

   

	int fd = tap_open("tap0");
   // dev = pico_tap_create("tap0");

	printf("after tap_open ********** %d \n",fd);
    if (!dev)
        return -1;

    pico_string_to_ipv4("192.168.5.4", &ipaddr.addr);
    pico_string_to_ipv4("255.255.255.0", &netmask.addr);
    pico_ipv4_link_add(dev, ipaddr, netmask);

    printf("starting ping\n");
    id = pico_icmp4_ping("192.168.5.5", NUM_PING, 1000, 10000, 64, cb_ping);

    if (id == -1)
        return -1;

    while (finished != 1)
    {
        usleep(1000);
        pico_stack_tick();
    }

    printf("finished !\n");


    return 0;
}

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





static TEE_Result dec_value(uint32_t param_types,
	TEE_Param params[4])
{
	uint32_t exp_param_types = TEE_PARAM_TYPES(TEE_PARAM_TYPE_VALUE_INOUT,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE,
						   TEE_PARAM_TYPE_NONE);

	DMSG("has been called");

	if (param_types != exp_param_types)
		return TEE_ERROR_BAD_PARAMETERS;

	IMSG("[dec_value]Got value: %u from NW", params[0].value.a);
	params[0].value.a--;
	IMSG("[dec_value]Decrease value to: %u", params[0].value.a);

	ping_test();

	IMSG("[dec_value] after ping test\n");
	return TEE_SUCCESS;
}




static TEE_Result empty_test(uint32_t __unused param_types,
					TEE_Param __unused params[4])
					
{

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

	case TA_NET_TEST:
		return dec_value(param_types, params);



	default:
		return TEE_ERROR_BAD_PARAMETERS;
	}
}
