/* SPDX-License-Identifier: GPL-2.0
 *
 * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
 */

#ifndef _WG_BLAKE2S_H
#define _WG_BLAKE2S_H

#include "blake2.h"

struct blake2s_state {
	uint32_t h[8];
	uint32_t t[2];
	uint32_t f[2];
	uint8_t buf[BLAKE2S_BLOCKBYTES];
	size_t buflen;
	uint8_t last_node;
};



#endif /* _WG_BLAKE2S_H */
