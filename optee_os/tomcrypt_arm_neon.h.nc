#ifndef TOMCRYPT_ARM_NEON_H
#define TOMCRYPT_ARM_NEON_H
#include <tomcrypt_macros.h>
struct tomcrypt_arm_neon_state {
	ulong32 state;
};
void tomcrypt_arm_neon_enable(struct tomcrypt_arm_neon_state *state);
void tomcrypt_arm_neon_disable(struct tomcrypt_arm_neon_state *state);
#endif 
