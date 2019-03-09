/*********************************************************************
   PicoTCP. Copyright (c) 2012-2017 Altran Intelligent Systems. Some rights reserved.
   See COPYING, LICENSE.GPLv2 and LICENSE.GPLv3 for usage.
 *********************************************************************/

#ifndef PICO_SUPPORT_ARCHNONE
#define PICO_SUPPORT_ARCHNONE

#include <string.h>
#include <stdio.h>
#include <unstd.h>

#define dbg printf
#define pico_zalloc(x) malloc(x)
#define pico_free(x) free(x)
#define PICO_TIME() 666
#define PICO_TIME_MS() 666000
#define PICO_IDLE() do {} while(0)

#endif  /* PICO_SUPPORT_ARCHNONE */

