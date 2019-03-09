#ifndef TEE_COMMON_H
#define TEE_COMMON_H
#include <stdlib.h>
#ifdef MEASURE_TIME
void tee_mtime_init(void);
void tee_mtime_stamp(const char *descr);
void tee_mtime_report(void);
void tee_mtime_perftest(void);
#else
#define tee_mtime_init() do { } while (0)
#define tee_mtime_stamp(descr) do { } while (0)
#define tee_mtime_report() do { } while (0)
#define tee_mtime_perftest()  do { } while (0)
#endif
#endif 
