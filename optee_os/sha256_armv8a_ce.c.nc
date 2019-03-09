#include "tomcrypt.h"
#include "tomcrypt_arm_neon.h"
#if defined(LTC_SHA256_ARM32_CE) || defined(LTC_SHA256_ARM64_CE)
const struct ltc_hash_descriptor sha256_desc =
{
    "sha256",
    0,
    32,
    64,
   { 2, 16, 840, 1, 101, 3, 4, 2, 1,  },
   9,
    &sha256_init,
    &sha256_process,
    &sha256_done,
    &sha256_test,
    NULL
};
int sha256_ce_transform(ulong32 *state, unsigned char *buf, int blocks);
static int sha256_compress_nblocks(hash_state *md, unsigned char *buf, int blocks)
{
    struct tomcrypt_arm_neon_state state;
    tomcrypt_arm_neon_enable(&state);
    sha256_ce_transform(md->sha256.state, buf, blocks);
    tomcrypt_arm_neon_disable(&state);
    return CRYPT_OK;
}
static int sha256_compress(hash_state *md, unsigned char *buf)
{
   return sha256_compress_nblocks(md, buf, 1);
}
int sha256_init(hash_state * md)
{
    LTC_ARGCHK(md != NULL);
    md->sha256.curlen = 0;
    md->sha256.length = 0;
    md->sha256.state[0] = 0x6A09E667UL;
    md->sha256.state[1] = 0xBB67AE85UL;
    md->sha256.state[2] = 0x3C6EF372UL;
    md->sha256.state[3] = 0xA54FF53AUL;
    md->sha256.state[4] = 0x510E527FUL;
    md->sha256.state[5] = 0x9B05688CUL;
    md->sha256.state[6] = 0x1F83D9ABUL;
    md->sha256.state[7] = 0x5BE0CD19UL;
    return CRYPT_OK;
}
HASH_PROCESS_NBLOCKS(sha256_process, sha256_compress_nblocks, sha256, 64)
int sha256_done(hash_state * md, unsigned char *out)
{
    int i;
    LTC_ARGCHK(md  != NULL);
    LTC_ARGCHK(out != NULL);
    if (md->sha256.curlen >= sizeof(md->sha256.buf)) {
       return CRYPT_INVALID_ARG;
    }
    md->sha256.length += md->sha256.curlen * 8;
    md->sha256.buf[md->sha256.curlen++] = (unsigned char)0x80;
    if (md->sha256.curlen > 56) {
        while (md->sha256.curlen < 64) {
            md->sha256.buf[md->sha256.curlen++] = (unsigned char)0;
        }
        sha256_compress(md, md->sha256.buf);
        md->sha256.curlen = 0;
    }
    while (md->sha256.curlen < 56) {
        md->sha256.buf[md->sha256.curlen++] = (unsigned char)0;
    }
    STORE64H(md->sha256.length, md->sha256.buf+56);
    sha256_compress(md, md->sha256.buf);
    for (i = 0; i < 8; i++) {
        STORE32H(md->sha256.state[i], out+(4*i));
    }
#ifdef LTC_CLEAN_STACK
    zeromem(md, sizeof(hash_state));
#endif
    return CRYPT_OK;
}
int  sha256_test(void)
{
 #ifndef LTC_TEST
    return CRYPT_NOP;
 #else    
  static const struct {
      const char *msg;
      unsigned char hash[32];
  } tests[] = {
    { "abc",
      { 0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea,
        0x41, 0x41, 0x40, 0xde, 0x5d, 0xae, 0x22, 0x23,
        0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
        0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad }
    },
    { "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq",
      { 0x24, 0x8d, 0x6a, 0x61, 0xd2, 0x06, 0x38, 0xb8, 
        0xe5, 0xc0, 0x26, 0x93, 0x0c, 0x3e, 0x60, 0x39,
        0xa3, 0x3c, 0xe4, 0x59, 0x64, 0xff, 0x21, 0x67, 
        0xf6, 0xec, 0xed, 0xd4, 0x19, 0xdb, 0x06, 0xc1 }
    },
  };
  int i;
  unsigned char tmp[32];
  hash_state md;
  for (i = 0; i < (int)(sizeof(tests) / sizeof(tests[0])); i++) {
      sha256_init(&md);
      sha256_process(&md, (unsigned char*)tests[i].msg, (unsigned long)strlen(tests[i].msg));
      sha256_done(&md, tmp);
      if (XMEMCMP(tmp, tests[i].hash, 32) != 0) {
         return CRYPT_FAIL_TESTVECTOR;
      }
  }
  return CRYPT_OK;
 #endif
}
#endif
