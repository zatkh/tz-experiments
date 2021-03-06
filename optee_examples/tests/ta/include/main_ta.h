/*
 * Copyright (c) 2016-2017, Linaro Limited
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
#ifndef TA_HELLO_WORLD_H
#define TA_HELLO_WORLD_H

#include "../common/common.h"

/*
 * This UUID is generated with uuidgen
 * the ITU-T UUID generator at http://www.itu.int/ITU-T/asn1/uuid.html
 */
#define HELLO_ENCLAVE \
	{ 0x7089f704, 0x47cf, 0x410c, \
		{ 0xbc, 0xf5, 0xff, 0xf3, 0xbb, 0x1c, 0x65, 0xfd} }



/* The function IDs implemented in this TA */
#define ECALL_INC_VAL		0
#define TA_BMFS_TEST 2
#define TA_LIBM_TEST 3



#define TA_OPEN_FILE_TEST 5
#define TA_WRITE_FILE_TEST 6
#define TA_READ_FILE_TEST 7
#define TA_SEEK_FILE_TEST 8
#define TA_EMPTY_TEST 9
#define TA_BMFS_CLEAN 10
#define ECALL_TEST_FROM_TA 11
#define ECALL_TIME 12


#endif /*TA_HELLO_WORLD_H*/
