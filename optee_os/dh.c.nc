#include <tomcrypt.h>
#ifdef LTC_LINARO_FIX_DH
#include <stdint.h>
int dh_make_key(prng_state *prng, int wprng, void *q, int xbits, dh_key *key)
{
	const int limit = 500;	
	int err, i;
	int key_size = 0;	
	int key_size_p = 0;	
	int key_size_q = 0;	
	void *arg_mod;
	uint8_t *buf = 0;	
	int found = 0;
	LTC_ARGCHK(key  != NULL);
	LTC_ARGCHK(key->g  != NULL);
	LTC_ARGCHK(key->p  != NULL);
	err = prng_is_valid(wprng);
	if (err != CRYPT_OK)
		return err;
	if (xbits) {
		LTC_ARGCHK((xbits % 8) == 0);
		key_size = xbits / 8;
	}
	key_size_p = mp_unsigned_bin_size(key->p);
	if (q)
		key_size_q = mp_unsigned_bin_size(q);
	if (key_size) {
		LTC_ARGCHK(key_size <= key_size_p);
		LTC_ARGCHK((q == NULL) || (key_size <= key_size_q));
	} else {
		if (q)
			key_size = MIN(key_size_p, key_size_q);
		else
			key_size =key_size_p;
	}
	if ((q != NULL) && (key_size_q < key_size_p))
		arg_mod = q;
	else
		arg_mod = key->p;
	key->x = NULL;
	key->y = NULL;
	err = mp_init_multi(&key->x, &key->y, NULL);
	if (err != CRYPT_OK)
		goto error;
	buf = XMALLOC(key_size);
	if (buf == NULL) {
		err = CRYPT_MEM;
		goto error;
	}
	for (i = 0; (i < limit) && (!found); i++) {
		if (prng_descriptor[wprng]->read(buf, key_size, prng) !=
		    (unsigned long)key_size) {
			err = CRYPT_ERROR_READPRNG;
			goto error;
		}
		if (xbits)
		      buf[0] |= 0x80;
		err = mp_read_unsigned_bin(key->x, buf, key_size);
		if (err != CRYPT_OK)
			goto error;
		err = mp_read_unsigned_bin(key->y, buf, key_size);
		if (err != CRYPT_OK)
			goto error;
		err = mp_mod(key->y, arg_mod, key->x);
		if (err != CRYPT_OK)
			goto error;
		if (xbits) {
			if (mp_count_bits(key->x) != xbits)
				continue;
		}
		found = 1;
	}
	if (!found) {
		err = CRYPT_PK_NOT_FOUND;
		goto error;
	}
	err = mp_exptmod(key->g, key->x, key->p, key->y);
	if (err != CRYPT_OK)
		goto error;
	err = CRYPT_OK;
error:
	if (err != CRYPT_OK)
		mp_clear_multi(key->x, key->y, NULL);
	if (buf)
		XFREE(buf);
	return err;
}
void dh_free(dh_key *key)
{
	if (key->x) {
		mp_clear(key->x);
		key->x = NULL;
	}
	if (key->y) {
		mp_clear(key->y);
		key->y = NULL;
	}
}
int dh_shared_secret(dh_key *private_key, void *public_key, void *secret)
{
	LTC_ARGCHK(private_key != NULL);
	LTC_ARGCHK(public_key  != NULL);
	LTC_ARGCHK(secret      != NULL);
	if (private_key->type != PK_PRIVATE)
		return CRYPT_PK_NOT_PRIVATE;
	return mp_exptmod(public_key, private_key->x, private_key->p, secret);
}
#endif
