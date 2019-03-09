/* strtoul( const char *, char * *, int )

   This file is part of the Public Domain C Library (PDCLib).
   Permission is granted to use, modify, and / or redistribute at will.
*/

#include <limits.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
#include <stddef.h>
char _PDCLIB_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";

const char * _PDCLIB_strtox_prelim( const char * p, char * sign, int * base )
{
    /* skipping leading whitespace */
    while ( isspace( *p ) ) ++p;
    /* determining / skipping sign */
    if ( *p != '+' && *p != '-' ) *sign = '+';
    else *sign = *(p++);
    /* determining base */
    if ( *p == '0' )
    {
        ++p;
        if ( ( *base == 0 || *base == 16 ) && ( *p == 'x' || *p == 'X' ) )
        {
            *base = 16;
            ++p;
            /* catching a border case here: "0x" followed by a non-digit should
               be parsed as the unprefixed zero.
               We have to "rewind" the parsing; having the base set to 16 if it
               was zero previously does not hurt, as the result is zero anyway.
            */
            if ( memchr( _PDCLIB_digits, tolower(*p), *base ) == NULL )
            {
                p -= 2;
            }
        }
        else if ( *base == 0 )
        {
            *base = 8;
        }
        else
        {
            --p;
        }
    }
    else if ( ! *base )
    {
        *base = 10;
    }
    return ( ( *base >= 2 ) && ( *base <= 36 ) ) ? p : NULL;
}

_PDCLIB_uintmax_t _PDCLIB_strtox_main( const char ** p, unsigned int base, uintmax_t error, uintmax_t limval, int limdigit, char * sign )
{
    _PDCLIB_uintmax_t rc = 0;
    int digit = -1;
    const char * x;
    while ( ( x = memchr( _PDCLIB_digits, tolower(**p), base ) ) != NULL )
    {
        digit = x - _PDCLIB_digits;
        if ( ( rc < limval ) || ( ( rc == limval ) && ( digit <= limdigit ) ) )
        {
            rc = rc * base + (unsigned)digit;
            ++(*p);
        }
        else
        {
            errno = ERANGE;
            /* TODO: Only if endptr != NULL - but do we really want *another* parameter? */
            /* TODO: Earlier version was missing tolower() here but was not caught by tests */
            while ( memchr( _PDCLIB_digits, tolower(**p), base ) != NULL ) ++(*p);
            /* TODO: This is ugly, but keeps caller from negating the error value */
            *sign = '+';
            return error;
        }
    }
    if ( digit == -1 )
    {
        *p = NULL;
        return 0;
    }
    return rc;
}


unsigned long int strtoul( const char * s, char ** endptr, int base )
{
    unsigned long int rc;
    char sign = '+';
    const char * p = _PDCLIB_strtox_prelim( s, &sign, &base );
    if ( base < 2 || base > 36 ) return 0;
    rc = (unsigned long int)_PDCLIB_strtox_main( &p, (unsigned)base, (uintmax_t)ULONG_MAX, (uintmax_t)( ULONG_MAX / base ), (int)( ULONG_MAX % base ), &sign );
    if ( endptr != NULL ) *endptr = ( p != NULL ) ? (char *) p : (char *) s;
    return ( sign == '+' ) ? rc : -rc;
}




