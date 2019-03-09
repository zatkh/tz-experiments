#include <bmfs/dir.h>
#include <bmfs/errno.h>
#include <bmfs/fs.h>
#include <bmfs/limits.h>
#include <bmfs/ramdisk.h>
#include <stdlib.h>
#include <string.h>
#include "bmfs_assert.h"
int test_fs (void)
{
	size_t buf_size = BMFS_BLOCK_SIZE * 12;
	void *buf = malloc(buf_size);
	struct BMFSRamdisk ramdisk;
	bmfs_ramdisk_init(&ramdisk);
	int err = bmfs_ramdisk_set_buf(&ramdisk, buf, buf_size);
	bmfs_assert(err == 0);
}
