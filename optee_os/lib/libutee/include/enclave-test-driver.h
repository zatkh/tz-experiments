
#ifndef __ENCLAVE_TEST_H
#define __ENCLAVE_TEST_H

/*
 * Interface to the gprof pseudo-TA, which is used by libutee to control TA
 * profiling and forward data to tee-supplicant.
 */

#define PTA_THELLO_UUID { 0x4974b40c, 0xfcb8, 0x4f1e, { \
			 0x9e, 0x0f, 0x87, 0xc1, 0xb7, 0x6d, 0x36, 0x9b } }




#define ENCLAVE_CONSOLE_TEST 40
#define PTA_TEST_OCALL 41
#define USLEEP 42
#define PTA_FILE_OCALL 43
#define O_CLOSE 44
#define O_READ 45
#define O_WRITE 46
#define O_TAP_OPEN 47
#define O_OPEN 48
#endif /* __ENCLAVE_TEST_H*/

