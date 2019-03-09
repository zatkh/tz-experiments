#ifndef TRACE_TA_H
#define TRACE_TA_H
#include <trace.h>
#ifdef CFG_TEE_CORE_TA_TRACE
#define TAMSG(...)	EMSG(__VA_ARGS__)
#define TAMSG_RAW(...)	EMSG_RAW(__VA_ARGS__)
#else
#define TAMSG(...)
#define TAMSG_RAW(...)
#endif
#endif 
