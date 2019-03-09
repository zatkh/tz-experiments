#ifndef GEN_ASM_DEFINES_H
#define GEN_ASM_DEFINES_H
#define DEFINES void __defines(void); void __defines(void)
#define DEFINE(def, val) \
	asm volatile("\n==>" #def " %0 " #val : : "i" (val))
#endif 
