#include "tomcrypt.h"
const struct ltc_hash_descriptor *hash_descriptor[TAB_SIZE];
LTC_MUTEX_GLOBAL(ltc_hash_mutex)
