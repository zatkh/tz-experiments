#include "tomcrypt.h"
const struct ltc_prng_descriptor *prng_descriptor[TAB_SIZE];
LTC_MUTEX_GLOBAL(ltc_prng_mutex)
