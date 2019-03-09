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

struct timespec
{
    time_t tv_sec;
    long tv_nsec;
};


struct tm
{
    int tm_sec;   /* 0-60 */
    int tm_min;   /* 0-59 */
    int tm_hour;  /* 0-23 */
    int tm_mday;  /* 1-31 */
    int tm_mon;   /* 0-11 */
    int tm_year;  /* years since 1900 */
    int tm_wday;  /* 0-6 */
    int tm_yday;  /* 0-365 */
    int tm_isdst; /* >0 DST, 0 no DST, <0 information unavailable */
};

struct timezone {
    int tz_minuteswest;
    int tz_dsttime;
};

// TODO complete later
int gettimeofday(struct timeval *tv, struct timezone *tz);


time_t time( time_t * timer ) ;

int timespec_get( struct timespec * ts, int base ) ;


#endif /*TIME_H*/











