#include "tomcrypt.h"
const struct ltc_cipher_descriptor *cipher_descriptor[TAB_SIZE];
LTC_MUTEX_GLOBAL(ltc_cipher_mutex)
