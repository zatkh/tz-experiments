/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (c) 2014, STMicroelectronics International N.V.
 */
#ifndef STDIO_H
#define STDIO_H

#include <stddef.h>
#include <stdarg.h>


int printf(const char *fmt, ...)
                    __attribute__ ((__format__ (__printf__, 1, 2)));
int snprintf(char *str, size_t size, const char *fmt, ...)
                    __attribute__ ((__format__ (__printf__, 3, 4)));
int vsnprintf (char *str, size_t size, const char *fmt, va_list ap)
                    __attribute__ ((__format__ (__printf__, 3, 0)));

int puts(const char *str);
int putchar(int c);

struct _FILE;
typedef struct _FILE {
    size_t (*write)(struct _FILE *f, const char *, size_t);
    char *wpos;
    char *wend;
} FILE;
int fflush(FILE *);
int fprintf(FILE *, const char *, ...);
int rename(const char *, const char *);
extern FILE *stdout;
extern FILE *stderr;
int sscanf(const char *, const char *, ...);
extern int vfprintf(FILE *, const char *, va_list);
/*
 * The following definitions are not required by the OCaml runtime, but are
 * needed to build the freestanding version of GMP used by Mirage.
 */
#define EOF (-1)
extern FILE *stdin;
size_t fread(void *, size_t, size_t, FILE *);
int getc(FILE *);
int ungetc(int, FILE *);
size_t fwrite(const void *, size_t, size_t, FILE *);
int fputc(int, FILE *);
int putc(int, FILE *);
int ferror(FILE *);

#endif /*STDIO_H*/



