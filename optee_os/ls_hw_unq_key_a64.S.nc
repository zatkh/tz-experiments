#include <asm.S>
FUNC get_hw_unique_key , :
	smc #0
	ret
END_FUNC get_hw_unique_key
