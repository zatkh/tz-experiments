#ifdef LTC_BASE64
int base64_encode(const unsigned char *in,  unsigned long len, 
                        unsigned char *out, unsigned long *outlen);
int base64_decode(const unsigned char *in,  unsigned long len, 
                        unsigned char *out, unsigned long *outlen);
#endif
#ifdef LTC_BASE64_URL
int base64url_encode(const unsigned char *in,  unsigned long len,
                        unsigned char *out, unsigned long *outlen);
int base64url_decode(const unsigned char *in,  unsigned long len,
                        unsigned char *out, unsigned long *outlen);
#endif
int mem_neq(const void *a, const void *b, size_t len);
void zeromem(volatile void *dst, size_t len);
void burn_stack(unsigned long len);
const char *error_to_string(int err);
extern const char *crypt_build_settings;
int crypt_fsa(void *mp, ...);
