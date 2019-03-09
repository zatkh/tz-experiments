/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (c) 2014, STMicroelectronics International N.V.
 */
#ifndef SIGNAL_H
#define SIGNAL_H


/* Signal handling <string.h>

   This file is part of the Public Domain C Library (PDCLib).
   Permission is granted to use, modify, and / or redistribute at will.
*/


#include "_PDCLIB_config.h"


/* These are the values used by Linux. */

/* Abnormal termination / abort() */
#define SIGABRT 6
/* Arithmetic exception / division by zero / overflow */
#define SIGFPE  8
/* Illegal instruction */
#define SIGILL  4
/* Interactive attention signal */
#define SIGINT  2
/* Invalid memory access */
#define SIGSEGV 11
/* Termination request */
#define SIGTERM 15

/* The following should be defined to pointer values that could NEVER point to
   a valid signal handler function. (They are used as special arguments to
   signal().) Again, these are the values used by Linux.
*/
#define SIG_DFL (void (*)( int ))0
#define SIG_ERR (void (*)( int ))-1
#define SIG_IGN (void (*)( int ))1

typedef _PDCLIB_sig_atomic sig_atomic_t;

/* Installs a signal handler "func" for the given signal.
   A signal handler is a function that takes an integer as argument (the signal
   number) and returns void.

   Note that a signal handler can do very little else than:
   1) assign a value to a static object of type "volatile sig_atomic_t",
   2) call signal() with the value of sig equal to the signal received,
   3) call _Exit(),
   4) call abort().
   Virtually everything else is undefind.

   The signal() function returns the previous installed signal handler, which
   at program start may be SIG_DFL or SIG_ILL. (This implementation uses
   SIG_DFL for all handlers.) If the request cannot be honored, SIG_ERR is
   returned and errno is set to an unspecified positive value.
*/
void (*signal( int sig, void (*func)( int ) ) )( int );


typedef int sigjmp_buf;
typedef int sigset_t;
struct sigaction {
    void (*sa_handler)(int);
    sigset_t sa_mask;
    int sa_flags;
};
#define SIG_DFL NULL
#define SIG_IGN NULL
int sigaction(int, const struct sigaction *, struct sigaction *);
int sigsetjmp(sigjmp_buf, int);
int sigaddset(sigset_t *set, int);
int sigdelset(sigset_t *set, int);
int sigemptyset(sigset_t *set);
#define SIG_BLOCK 0
#define SIG_SETMASK 0
int sigprocmask(int, const sigset_t *, sigset_t *);
/*
 * The following definitions are not required by the OCaml runtime, but are
 * needed to build the freestanding version of GMP used by Mirage.
 */
#define SIGFPE 1
int raise(int);


#endif /*SIGNAL_H*/
