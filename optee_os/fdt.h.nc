#ifndef _FDT_H
#define _FDT_H
#ifndef __ASSEMBLY__
struct fdt_header {
	fdt32_t magic;			 
	fdt32_t totalsize;		 
	fdt32_t off_dt_struct;		 
	fdt32_t off_dt_strings;		 
	fdt32_t off_mem_rsvmap;		 
	fdt32_t version;		 
	fdt32_t last_comp_version;	 
	fdt32_t boot_cpuid_phys;	 
	fdt32_t size_dt_strings;	 
	fdt32_t size_dt_struct;		 
};
struct fdt_reserve_entry {
	fdt64_t address;
	fdt64_t size;
};
struct fdt_node_header {
	fdt32_t tag;
	char name[];
};
struct fdt_property {
	fdt32_t tag;
	fdt32_t len;
	fdt32_t nameoff;
	char data[];
};
#endif 
#define FDT_MAGIC	0xd00dfeed	
#define FDT_TAGSIZE	sizeof(fdt32_t)
#define FDT_BEGIN_NODE	0x1		
#define FDT_END_NODE	0x2		
#define FDT_PROP	0x3		
#define FDT_NOP		0x4		
#define FDT_END		0x9
#define FDT_V1_SIZE	(7*sizeof(fdt32_t))
#define FDT_V2_SIZE	(FDT_V1_SIZE + sizeof(fdt32_t))
#define FDT_V3_SIZE	(FDT_V2_SIZE + sizeof(fdt32_t))
#define FDT_V16_SIZE	FDT_V3_SIZE
#define FDT_V17_SIZE	(FDT_V16_SIZE + sizeof(fdt32_t))
#endif 
