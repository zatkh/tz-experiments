#include <arm.h>
#include <kernel/delay.h>
void udelay(uint32_t us)
{
	uint64_t start, target;
	start = read_cntpct();
	target = read_cntfrq() / 1000000ULL * us;
	while (read_cntpct() - start <= target)
		;
}
