#ifndef UNSUPPORTED_LIBC_H
#define UNSUPPORTED_LIBC_H

#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <string.h>
#include <ctype.h>




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



ldiv_t ldiv (long num, long denom);
int strcmp(const char *l, const char *r);
char *strcpy(char *restrict dest, const char *restrict src);
int strcasecmp(const char *s1 ,const char *s2);
int strncmp(const char *_l, const char *_r, size_t n);
int toupper(int ch);
int tolower(int ch);

#endif //UNSUPPORTED_LIBC_H