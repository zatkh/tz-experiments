#include <inttypes.h>
#include <kernel/tee_common_otp.h>
__weak void tee_otp_get_hw_unique_key(struct tee_hw_unique_key *hwkey)
{
	memset(&hwkey->data[0], 0, sizeof(hwkey->data));
}
__weak int tee_otp_get_die_id(uint8_t *buffer, size_t len)
{
	static const char pattern[4] = { 'B', 'E', 'E', 'F' };
	size_t i;
	for (i = 0; i < len; i++)
		buffer[i] = pattern[i % 4];
	return 0;
}
