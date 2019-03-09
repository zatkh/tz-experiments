#include "tomcrypt.h"
#ifdef LTC_PMAC
int pmac_done(pmac_state *state, unsigned char *out, unsigned long *outlen)
{
   int err, x;
   LTC_ARGCHK(state != NULL);
   LTC_ARGCHK(out   != NULL);
   if ((err = cipher_is_valid(state->cipher_idx)) != CRYPT_OK) {
      return err;
   }
   if ((state->buflen > (int)sizeof(state->block)) || (state->buflen < 0) ||
       (state->block_len > (int)sizeof(state->block)) || (state->buflen > state->block_len)) {
      return CRYPT_INVALID_ARG;
   }
   if (state->buflen == state->block_len) {
      for (x = 0; x < state->block_len; x++) {
          state->checksum[x] ^= state->block[x] ^ state->Lr[x];
      }
   } else {
      for (x = 0; x < state->buflen; x++) {
          state->checksum[x] ^= state->block[x];
      }
      state->checksum[x] ^= 0x80;
   }
   if ((err = cipher_descriptor[state->cipher_idx].ecb_encrypt(state->checksum, state->checksum, &state->key)) != CRYPT_OK) {
      return err;
   }
   cipher_descriptor[state->cipher_idx].done(&state->key);
   for (x = 0; x < state->block_len && x < (int)*outlen; x++) {
       out[x] = state->checksum[x];
   }
   *outlen = x;
#ifdef LTC_CLEAN_STACK
   zeromem(state, sizeof(*state));
#endif
   return CRYPT_OK;
}
#endif
