#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <sys/times.h>
#include <unistd.h>
#include <malloc.h>
#include <trace.h>
#include <utee_defines.h>

/*
 * Global errno lives in this module.
 */
int errno;

/*
 * Standard output and error "streams".
 */
static size_t console_write(FILE *f __attribute__((unused)), const char *s,
        size_t l)
{
    IMSG(s);
    return l;
}

static FILE console = { .write = console_write };
FILE *stderr = &console;
FILE *stdout = &console;

ssize_t write(int fd, const void *buf, size_t count)
{
    if (fd == 1 || fd == 2) {
        IMSG(buf);
        return count;
    }
    errno = ENOSYS;
    return -1;
}

void exit(int status)
{
}


/*
 * System time.
 */
#define NSEC_PER_SEC 1000000000ULL

int gettimeofday(struct timeval *tv, struct timezone *tz)
{
   /* if (tv != NULL) {
        solo5_time_t now = solo5_clock_wall();
        tv->tv_sec = now / NSEC_PER_SEC;
        tv->tv_usec = (now % NSEC_PER_SEC) / 1000ULL;
    }
    if (tz != NULL) {
        memset(tz, 0, sizeof(*tz));
    }
    */
    return 0;
}

clock_t times(struct tms *buf)
{
    memset(buf, 0, sizeof(*buf));
    clock_t ret=0;
    return ret;
    //return (clock_t)solo5_clock_monotonic();
}

static uintptr_t sbrk_start;
static uintptr_t sbrk_cur;
static uintptr_t sbrk_guard_size;

/*
 * To be called by Mirage/Solo5 before calling caml_startup().
 *
 * XXX: There is intentionally no public prototype for this function. There
 * should really be a caml_freestanding_startup(), but I'm lazy and don't have
 * a proper place to put it in the build system right now.
 */
void _nolibc_init(uintptr_t heap_start, size_t heap_size)
{
    /*
     * If we have <1MB of heap available at init time then don't let the heap
     * grow to within (heap_size / 2) of the stack, otherwise don't let it
     * grow to within 1MB of the stack.
     */
    sbrk_guard_size = (heap_size >= 0x100000) ?
        0x100000 : (heap_size / 2);

    sbrk_start = sbrk_cur = heap_start;
}

/*
 * Called by dlmalloc to allocate or free memory.
 */
void *sbrk(intptr_t increment)
{
    uintptr_t prev, brk;
    uintptr_t max = (uintptr_t)&prev - sbrk_guard_size;
    prev = brk = sbrk_cur;

    /*
     * dlmalloc guarantees increment values less than half of size_t, so this
     * is safe from overflow.
     */
    brk += increment;
    if (brk >= max || brk < sbrk_start)
        return (void *)-1;

    sbrk_cur = brk;
    return (void *)prev;
}

/*
 * dlmalloc configuration:
 */

/*
 * DEBUG not defined and assertions compiled out corresponds to the default
 * recommended configuration (see documentation below). If you need to debug
 * dlmalloc on Solo5 then define DEBUG to `1' here.
 */
#if defined(DEBUG) && (DEBUG)
#define ABORT_ON_ASSERT_FAILURE 0
#else
#undef assert
#define assert(x)
#define NO_MALLINFO 1
#endif

#undef WIN32
#define HAVE_MMAP 0
#define HAVE_MREMAP 0
#define MMAP_CLEARS 0
#define NO_MALLOC_STATS 1
#define LACKS_FCNTL_H
#define LACKS_SYS_PARAM_H
#define LACKS_SYS_MMAN_H
#define LACKS_STRINGS_H
#define LACKS_SYS_TYPES_H
#define LACKS_SCHED_H
#define LACKS_TIME_H
#define MALLOC_FAILURE_ACTION
#define USE_LOCKS 0

/* disable null-pointer-arithmetic warning on clang */
#if defined(__clang__) && __clang_major__ >= 6
#pragma clang diagnostic ignored "-Wnull-pointer-arithmetic"
#endif

/* inline the dlmalloc implementation into this module */
//#include "dlmalloc.i"

/*
 * When adding new functions to this module, add them BEFORE the "dlmalloc
 * configuration" comment above, not here.
 */
