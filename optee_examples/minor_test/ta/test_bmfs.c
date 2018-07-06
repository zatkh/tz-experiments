#include <bmfs/dir.h>
#include <bmfs/errno.h>
#include <bmfs/fs.h>
#include <bmfs/limits.h>
#include <bmfs/ramdisk.h>
#include <bmfs/encoding.h>

#include <stdlib.h>
#include <string.h>

#include "bmfs_assert.h"


static bmfs_bool test_encoding64(bmfs_uint64 n, const void *buf)
{
	unsigned char out[8];
	printf("test_encoding64\n");

	bmfs_encode_uint64(n, out);

	if (memcmp(out, buf, 8) == 0)
		return BMFS_TRUE;
	else
		return BMFS_FALSE;
}

static bmfs_bool test_encoding32(bmfs_uint32 n, const void *buf)
{
	unsigned char out[4];
	printf("test_encoding64\n");

	bmfs_encode_uint32(n, out);

	if (memcmp(out, buf, 4) == 0)
		return BMFS_TRUE;
	else
		return BMFS_FALSE;
}

int bmfs_test(void)
{
	bmfs_assert(test_encoding64(0x1122334455667788, "\x88\x77\x66\x55\x44\x33\x22\x11"));
	bmfs_assert(test_encoding32(0xaabbccdd, "\xdd\xcc\xbb\xaa"));

	return 0;

}

