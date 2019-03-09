#ifndef _LIBFDT_H
#define _LIBFDT_H
#include <libfdt_env.h>
#include <fdt.h>
#define FDT_FIRST_SUPPORTED_VERSION	0x10
#define FDT_LAST_SUPPORTED_VERSION	0x11
#define FDT_ERR_NOTFOUND	1
#define FDT_ERR_EXISTS		2
#define FDT_ERR_NOSPACE		3
#define FDT_ERR_BADOFFSET	4
#define FDT_ERR_BADPATH		5
#define FDT_ERR_BADPHANDLE	6
#define FDT_ERR_BADSTATE	7
#define FDT_ERR_TRUNCATED	8
#define FDT_ERR_BADMAGIC	9
#define FDT_ERR_BADVERSION	10
#define FDT_ERR_BADSTRUCTURE	11
#define FDT_ERR_BADLAYOUT	12
#define FDT_ERR_INTERNAL	13
#define FDT_ERR_BADNCELLS	14
#define FDT_ERR_MAX		14
const void *fdt_offset_ptr(const void *fdt, int offset, unsigned int checklen);
static inline void *fdt_offset_ptr_w(void *fdt, int offset, int checklen)
{
	return (void *)(uintptr_t)fdt_offset_ptr(fdt, offset, checklen);
}
uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
int fdt_next_node(const void *fdt, int offset, int *depth);
int fdt_first_subnode(const void *fdt, int offset);
int fdt_next_subnode(const void *fdt, int offset);
#define fdt_get_header(fdt, field) \
	(fdt32_to_cpu(((const struct fdt_header *)(fdt))->field))
#define fdt_magic(fdt) 			(fdt_get_header(fdt, magic))
#define fdt_totalsize(fdt)		(fdt_get_header(fdt, totalsize))
#define fdt_off_dt_struct(fdt)		(fdt_get_header(fdt, off_dt_struct))
#define fdt_off_dt_strings(fdt)		(fdt_get_header(fdt, off_dt_strings))
#define fdt_off_mem_rsvmap(fdt)		(fdt_get_header(fdt, off_mem_rsvmap))
#define fdt_version(fdt)		(fdt_get_header(fdt, version))
#define fdt_last_comp_version(fdt) 	(fdt_get_header(fdt, last_comp_version))
#define fdt_boot_cpuid_phys(fdt) 	(fdt_get_header(fdt, boot_cpuid_phys))
#define fdt_size_dt_strings(fdt) 	(fdt_get_header(fdt, size_dt_strings))
#define fdt_size_dt_struct(fdt)		(fdt_get_header(fdt, size_dt_struct))
#define __fdt_set_hdr(name) \
	static inline void fdt_set_##name(void *fdt, uint32_t val) \
	{ \
		struct fdt_header *fdth = (struct fdt_header*)fdt; \
		fdth->name = cpu_to_fdt32(val); \
	}
__fdt_set_hdr(magic)
__fdt_set_hdr(totalsize)
__fdt_set_hdr(off_dt_struct)
__fdt_set_hdr(off_dt_strings)
__fdt_set_hdr(off_mem_rsvmap)
__fdt_set_hdr(version)
__fdt_set_hdr(last_comp_version)
__fdt_set_hdr(boot_cpuid_phys)
__fdt_set_hdr(size_dt_strings)
__fdt_set_hdr(size_dt_struct)
#undef __fdt_set_hdr
int fdt_check_header(const void *fdt);
int fdt_move(const void *fdt, void *buf, int bufsize);
const char *fdt_string(const void *fdt, int stroffset);
int fdt_num_mem_rsv(const void *fdt);
int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size);
int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
			       const char *name, int namelen);
int fdt_subnode_offset(const void *fdt, int parentoffset, const char *name);
int fdt_path_offset(const void *fdt, const char *path);
const char *fdt_get_name(const void *fdt, int nodeoffset, int *lenp);
int fdt_first_property_offset(const void *fdt, int nodeoffset);
int fdt_next_property_offset(const void *fdt, int offset);
const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
						      int offset,
						      int *lenp);
const struct fdt_property *fdt_get_property_namelen(const void *fdt,
						    int nodeoffset,
						    const char *name,
						    int namelen, int *lenp);
const struct fdt_property *fdt_get_property(const void *fdt, int nodeoffset,
					    const char *name, int *lenp);
static inline struct fdt_property *fdt_get_property_w(void *fdt, int nodeoffset,
						      const char *name,
						      int *lenp)
{
	return (struct fdt_property *)(uintptr_t)
		fdt_get_property(fdt, nodeoffset, name, lenp);
}
const void *fdt_getprop_by_offset(const void *fdt, int offset,
				  const char **namep, int *lenp);
const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
				const char *name, int namelen, int *lenp);
const void *fdt_getprop(const void *fdt, int nodeoffset,
			const char *name, int *lenp);
static inline void *fdt_getprop_w(void *fdt, int nodeoffset,
				  const char *name, int *lenp)
{
	return (void *)(uintptr_t)fdt_getprop(fdt, nodeoffset, name, lenp);
}
uint32_t fdt_get_phandle(const void *fdt, int nodeoffset);
const char *fdt_get_alias_namelen(const void *fdt,
				  const char *name, int namelen);
const char *fdt_get_alias(const void *fdt, const char *name);
int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen);
int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
				 int supernodedepth, int *nodedepth);
int fdt_node_depth(const void *fdt, int nodeoffset);
int fdt_parent_offset(const void *fdt, int nodeoffset);
int fdt_node_offset_by_prop_value(const void *fdt, int startoffset,
				  const char *propname,
				  const void *propval, int proplen);
int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle);
int fdt_node_check_compatible(const void *fdt, int nodeoffset,
			      const char *compatible);
int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
				  const char *compatible);
int fdt_stringlist_contains(const char *strlist, int listlen, const char *str);
#define FDT_MAX_NCELLS		4
int fdt_address_cells(const void *fdt, int nodeoffset);
int fdt_size_cells(const void *fdt, int nodeoffset);
int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
			const void *val, int len);
static inline int fdt_setprop_inplace_u32(void *fdt, int nodeoffset,
					  const char *name, uint32_t val)
{
	fdt32_t tmp = cpu_to_fdt32(val);
	return fdt_setprop_inplace(fdt, nodeoffset, name, &tmp, sizeof(tmp));
}
static inline int fdt_setprop_inplace_u64(void *fdt, int nodeoffset,
					  const char *name, uint64_t val)
{
	fdt64_t tmp = cpu_to_fdt64(val);
	return fdt_setprop_inplace(fdt, nodeoffset, name, &tmp, sizeof(tmp));
}
static inline int fdt_setprop_inplace_cell(void *fdt, int nodeoffset,
					   const char *name, uint32_t val)
{
	return fdt_setprop_inplace_u32(fdt, nodeoffset, name, val);
}
int fdt_nop_property(void *fdt, int nodeoffset, const char *name);
int fdt_nop_node(void *fdt, int nodeoffset);
int fdt_create(void *buf, int bufsize);
int fdt_resize(void *fdt, void *buf, int bufsize);
int fdt_add_reservemap_entry(void *fdt, uint64_t addr, uint64_t size);
int fdt_finish_reservemap(void *fdt);
int fdt_begin_node(void *fdt, const char *name);
int fdt_property(void *fdt, const char *name, const void *val, int len);
static inline int fdt_property_u32(void *fdt, const char *name, uint32_t val)
{
	fdt32_t tmp = cpu_to_fdt32(val);
	return fdt_property(fdt, name, &tmp, sizeof(tmp));
}
static inline int fdt_property_u64(void *fdt, const char *name, uint64_t val)
{
	fdt64_t tmp = cpu_to_fdt64(val);
	return fdt_property(fdt, name, &tmp, sizeof(tmp));
}
static inline int fdt_property_cell(void *fdt, const char *name, uint32_t val)
{
	return fdt_property_u32(fdt, name, val);
}
#define fdt_property_string(fdt, name, str) \
	fdt_property(fdt, name, str, strlen(str)+1)
int fdt_end_node(void *fdt);
int fdt_finish(void *fdt);
int fdt_create_empty_tree(void *buf, int bufsize);
int fdt_open_into(const void *fdt, void *buf, int bufsize);
int fdt_pack(void *fdt);
int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size);
int fdt_del_mem_rsv(void *fdt, int n);
int fdt_set_name(void *fdt, int nodeoffset, const char *name);
int fdt_setprop(void *fdt, int nodeoffset, const char *name,
		const void *val, int len);
static inline int fdt_setprop_u32(void *fdt, int nodeoffset, const char *name,
				  uint32_t val)
{
	fdt32_t tmp = cpu_to_fdt32(val);
	return fdt_setprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
}
static inline int fdt_setprop_u64(void *fdt, int nodeoffset, const char *name,
				  uint64_t val)
{
	fdt64_t tmp = cpu_to_fdt64(val);
	return fdt_setprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
}
static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const char *name,
				   uint32_t val)
{
	return fdt_setprop_u32(fdt, nodeoffset, name, val);
}
#define fdt_setprop_string(fdt, nodeoffset, name, str) \
	fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
int fdt_appendprop(void *fdt, int nodeoffset, const char *name,
		   const void *val, int len);
static inline int fdt_appendprop_u32(void *fdt, int nodeoffset,
				     const char *name, uint32_t val)
{
	fdt32_t tmp = cpu_to_fdt32(val);
	return fdt_appendprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
}
static inline int fdt_appendprop_u64(void *fdt, int nodeoffset,
				     const char *name, uint64_t val)
{
	fdt64_t tmp = cpu_to_fdt64(val);
	return fdt_appendprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
}
static inline int fdt_appendprop_cell(void *fdt, int nodeoffset,
				      const char *name, uint32_t val)
{
	return fdt_appendprop_u32(fdt, nodeoffset, name, val);
}
#define fdt_appendprop_string(fdt, nodeoffset, name, str) \
	fdt_appendprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
int fdt_delprop(void *fdt, int nodeoffset, const char *name);
int fdt_add_subnode_namelen(void *fdt, int parentoffset,
			    const char *name, int namelen);
int fdt_add_subnode(void *fdt, int parentoffset, const char *name);
int fdt_del_node(void *fdt, int nodeoffset);
const char *fdt_strerror(int errval);
#endif 
