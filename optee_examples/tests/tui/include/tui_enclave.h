
#ifndef TUI_H
#define TUI_H

#include "../common/common.h"

/*
 * This UUID is generated with uuidgen
 * the ITU-T UUID generator at http://www.itu.int/ITU-T/asn1/uuid.html
 */
//9549c6d8-782e-4ad6-b25b-52f2263f1827


#define TUI_UUID \
	{ 0x9549c6d8, 0x782e, 0x4ad6, \
		{ 0xb2, 0x5b, 0x52, 0xf2, 0x26, 0x3f, 0x18, 0x27} }



/* The function IDs implemented in this TA */
#define ECALL_INC_VAL		0
#define ECALL_PUTS 1


#endif /*TUI_H*/
