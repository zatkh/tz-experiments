#include "unsupported-libc.h"




ldiv_t ldiv (long num, long denom)
{
	ldiv_t r;

	/* see div.c for comments */

	r.quot = num / denom;
	r.rem = num % denom;
	if (num >= 0 && r.rem < 0) {
		++r.quot;
		r.rem -= denom;
	}
	else if (num < 0 && r.rem > 0) {
		--r.quot;
		r.rem += denom;
	}
	return (r);
}


int strcmp(const char *l, const char *r)
{
    for (; *l==*r && *l; l++, r++);
    return *(unsigned char *)l - *(unsigned char *)r;
}

char *strcpy(char *restrict dest, const char *restrict src)
{
    const unsigned char *s = (const unsigned char *)src;
    unsigned char *d = (unsigned char *)dest;
    while ((*d++ = *s++));
    return dest;
}

int toupper(int ch)
{
        if(ch >= 'a' && ch <= 'z')
                return ('A' + ch - 'a');
        else
                return ch;
}

int tolower(int ch)
{
        if(ch >= 'A' && ch <= 'Z')
                return ('a' + ch - 'A');
        else
                return ch;
}

int strcasecmp(const char *s1 ,const char *s2)
{
  const unsigned char *ucs1 = (const unsigned char *) s1;
  const unsigned char *ucs2 = (const unsigned char *) s2;
  int d = 0;
  for ( ; ; )
    {
      const int c1 = tolower(*ucs1++);
      const int c2 = tolower(*ucs2++);
      if (((d = c1 - c2) != 0) || (c2 == '\0'))
        break;
    }
  return d;
}

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l=(void *)_l, *r=(void *)_r;
    if (!n--) return 0;
    for (; *l && *r && n && *l == *r ; l++, r++, n--);
    return *l - *r;
}
