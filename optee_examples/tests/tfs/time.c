/* ===============================================================
 * Baremetal File System - A file system designed for BareMetal OS
 * Copyright (C) 2008 - 2018 Return Infinity
 * See COPYING for license information.
 * ===============================================================
 */

#include <bmfs/time.h>
#include <time.h>
#include <tee_api.h>


int bmfs_get_current_time(bmfs_uint64 *time_ptr) {

	TEE_Time _time;
	TEE_GetSystemTime(&_time);
	*time_ptr = _time.seconds;


	return 0;
}
	