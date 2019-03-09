/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (c) 2014, STMicroelectronics International N.V.
 */

/*
 * This file provides what C99 standard requires for <stdlib.h> in
 * 7.20.3 Memory management functions
 */

#ifndef STDLIB_H
#define STDLIB_H

#include <compiler.h>
#include <stddef.h>
#include <malloc.h>

typedef struct 
{
  int quot; /* quotient */
  int rem; /* remainder */
} div_t;

typedef struct 
{
  long quot; /* quotient */
  long rem; /* remainder */
} ldiv_t;


void
qsort(void *aa, size_t n, size_t es, int (*cmp)(const void *, const void *));

void abort(void) __noreturn;

int abs(int i);

/* The largest number returned by rand() */
#define	RAND_MAX	__INT_MAX__
int rand(void);

long strtol(const char *, char **, int);

void exit(int) __attribute__((noreturn));
char *getenv(const char *);
char *secure_getenv(const char *);
int system(const char *);
double strtod(const char *, char **);

ldiv_t ldiv (long num, long denom);
//long long int strtoll( const char *  nptr, char * * _PDCLIB_restrict endptr, int base ) _PDCLIB_nothrow;
//unsigned long int strtoul( const char *  nptr, char * *  endptr, int base ) ;
//unsigned long long int strtoull( const char * _PDCLIB_restrict nptr, char * * _PDCLIB_restrict endptr, int base ) _PDCLIB_nothrow;


#endif /* STDLIB_H */


