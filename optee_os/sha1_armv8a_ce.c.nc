#include "tomcrypt.h"
#include "tomcrypt_arm_neon.h"
#if defined(LTC_SHA1_ARM32_CE) || defined(LTC_SHA1_ARM64_CE)
const struct ltc_hash_descriptor sha1_desc =
{
    "sha1",
    2,
    20,
    64,
   { 1, 3, 14, 3, 2, 26,  },
   6,
    &sha1_init,
    &sha1_process,
    &sha1_done,
    &sha1_test,
    NULL
};
void sha1_ce_transform(ulong32 *state, unsigned char *src, int blocks);
static int sha1_compress_nblocks(hash_state *md, unsigned char *buf, int blocks)
{
   struct tomcrypt_arm_neon_state state;
   COMPILE_TIME_ASSERT(sizeof(md->sha1.state[0]) == 4);
   tomcrypt_arm_neon_enable(&state);
   sha1_ce_transform(md->sha1.state, buf, blocks);
   tomcrypt_arm_neon_disable(&state);
   return CRYPT_OK;
}
static int sha1_compress(hash_state *md, unsigned char *buf)
{
   return sha1_compress_nblocks(md, buf, 1);
}
HASH_PROCESS_NBLOCKS(sha1_process, sha1_compress_nblocks, sha1, 64)
int sha1_init(hash_state * md)
{
   LTC_ARGCHK(md != NULL);
   md->sha1.state[0] = 0x67452301UL;
   md->sha1.state[1] = 0xefcdab89UL;
   md->sha1.state[2] = 0x98badcfeUL;
   md->sha1.state[3] = 0x10325476UL;
   md->sha1.state[4] = 0xc3d2e1f0UL;
   md->sha1.curlen = 0;
   md->sha1.length = 0;
   return CRYPT_OK;
}
int sha1_done(hash_state * md, unsigned char *out)
{
    int i;
    LTC_ARGCHK(md  != NULL);
    LTC_ARGCHK(out != NULL);
    if (md->sha1.curlen >= sizeof(md->sha1.buf)) {
       return CRYPT_INVALID_ARG;
    }
    md->sha1.length += md->sha1.curlen * 8;
    md->sha1.buf[md->sha1.curlen++] = (unsigned char)0x80;
    if (md->sha1.curlen > 56) {
        while (md->sha1.curlen < 64) {
            md->sha1.buf[md->sha1.curlen++] = (unsigned char)0;
        }
        sha1_compress(md, md->sha1.buf);
        md->sha1.curlen = 0;
    }
    while (md->sha1.curlen < 56) {
        md->sha1.buf[md->sha1.curlen++] = (unsigned char)0;
    }
    STORE64H(md->sha1.length, md->sha1.buf+56);
    sha1_compress(md, md->sha1.buf);
    for (i = 0; i < 5; i++) {
        STORE32H(md->sha1.state[i], out+(4*i));
    }
#ifdef LTC_CLEAN_STACK
    zeromem(md, sizeof(hash_state));
#endif
    return CRYPT_OK;
}
int  sha1_test(void)
{
 #ifndef LTC_TEST
    return CRYPT_NOP;
 #else
  static const struct {
      const char *msg;
      unsigned char hash[20];
  } tests[] = {
    { "abc",
      { 0xa9, 0x99, 0x3e, 0x36, 0x47, 0x06, 0x81, 0x6a,
        0xba, 0x3e, 0x25, 0x71, 0x78, 0x50, 0xc2, 0x6c,
        0x9c, 0xd0, 0xd8, 0x9d }
    },
    { "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq",
      { 0x84, 0x98, 0x3E, 0x44, 0x1C, 0x3B, 0xD2, 0x6E,
        0xBA, 0xAE, 0x4A, 0xA1, 0xF9, 0x51, 0x29, 0xE5,
        0xE5, 0x46, 0x70, 0xF1 }
    }
  };
  int i;
  unsigned char tmp[20];
  hash_state md;
  for (i = 0; i < (int)(sizeof(tests) / sizeof(tests[0]));  i++) {
      sha1_init(&md);
      sha1_process(&md, (unsigned char*)tests[i].msg, (unsigned long)strlen(tests[i].msg));
      sha1_done(&md, tmp);
      if (XMEMCMP(tmp, tests[i].hash, 20) != 0) {
         return CRYPT_FAIL_TESTVECTOR;
      }
  }
  return CRYPT_OK;
  #endif
}
#endif
