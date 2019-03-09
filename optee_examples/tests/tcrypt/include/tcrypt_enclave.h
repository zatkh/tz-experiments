
#ifndef TCRYPTO_ENCLAVE_H
#define TCRYPTO_ENCLAVE_H

#include "../common/common.h"

/*
 * This UUID is generated with uuidgen
 * the ITU-T UUID generator at http://www.itu.int/ITU-T/asn1/uuid.html
 */
//ea0ea0a8-f660-4435-8208-3c3d6c979722




#define TCRYPTO_UUID \
	{ 0xea0ea0a8, 0xf660, 0x4435, \
		{ 0x82, 0x08, 0x3c, 0x3d, 0x6c, 0x97, 0x97, 0x22} }



/* The function IDs implemented in this TA */
#define TA_HELLO_WORLD_CMD_INC_VALUE		0



#endif /*TCRYPTO_ENCLAVE_H*/
