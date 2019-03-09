/*********************************************************************
   PicoTCP. Copyright (c) 2012-2017 Altran Intelligent Systems. Some rights reserved.
   See COPYING, LICENSE.GPLv2 and LICENSE.GPLv3 for usage.
 *********************************************************************/

#ifndef PICO_SUPPORT_ARCHNONE
#define PICO_SUPPORT_ARCHNONE

#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <tee_api.h>

#define dbg printf
#define pico_zalloc(x) malloc(x)
#define pico_free(x) free(x)
/*
#define PICO_TIME() 666
#define PICO_TIME_MS() 666000
#define PICO_IDLE() do {} while(0)

*/

uint32_t esp_tick;


static inline unsigned long PICO_TIME(void)
{
   	TEE_Time _time;
	  TEE_GetSystemTime(&_time);
    return _time.seconds;
}

static inline unsigned long PICO_TIME_MS(void)
{
     	TEE_Time _time;
	  TEE_GetSystemTime(&_time);
    return _time.millis;

}

static inline void PICO_IDLE(void)
{
    uint32_t now = esp_tick;
    while (now == esp_tick)
        ;
}


	

#endif  /* PICO_SUPPORT_ARCHNONE */

