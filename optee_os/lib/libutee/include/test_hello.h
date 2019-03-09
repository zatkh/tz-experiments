
#ifndef __ENCLAVE_TEST_H
#define __ENCLAVE_TEST_H

/*
 * Interface to the gprof pseudo-TA, which is used by libutee to control TA
 * profiling and forward data to tee-supplicant.
 */

#define TEST_ENCLAVE_UUID { 0x4974b40c, 0xfcb8, 0x4f1e, { \
			 0x9e, 0x0f, 0x87, 0xc1, 0xb7, 0x6d, 0x36, 0x9b } }




#define ECALL_TEST 11
#define ENCLAVE_CONSOLE_TEST 12
#endif /* __ENCLAVE_TEST_H*/