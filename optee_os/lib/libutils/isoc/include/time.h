/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (c) 2014, STMicroelectronics International N.V.
 */
#ifndef TIME_H
#define TIME_H

#include <stddef.h>
#include <stdint.h>

typedef int64_t time_t;

typedef long suseconds_t;
struct timeval {
    time_t tv_sec;
    suseconds_t tv_usec;
};
struct timezone {
    int tz_minuteswest;
    int tz_dsttime;
};
int gettimeofday(struct timeval *tv, struct timezone *tz);



#endif /*TIME_H*/



