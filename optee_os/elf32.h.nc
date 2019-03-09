#ifndef _SYS_ELF32_H_
#define _SYS_ELF32_H_ 1
#include "elf_common.h"
typedef uint32_t	Elf32_Addr;
typedef uint16_t	Elf32_Half;
typedef uint32_t	Elf32_Off;
typedef int32_t		Elf32_Sword;
typedef uint32_t	Elf32_Word;
typedef uint64_t	Elf32_Lword;
typedef Elf32_Word	Elf32_Hashelt;
typedef Elf32_Word	Elf32_Size;
typedef Elf32_Sword	Elf32_Ssize;
typedef struct {
	unsigned char	e_ident[EI_NIDENT];	
	Elf32_Half	e_type;		
	Elf32_Half	e_machine;	
	Elf32_Word	e_version;	
	Elf32_Addr	e_entry;	
	Elf32_Off	e_phoff;	
	Elf32_Off	e_shoff;	
	Elf32_Word	e_flags;	
	Elf32_Half	e_ehsize;	
	Elf32_Half	e_phentsize;	
	Elf32_Half	e_phnum;	
	Elf32_Half	e_shentsize;	
	Elf32_Half	e_shnum;	
	Elf32_Half	e_shstrndx;	
} Elf32_Ehdr;
typedef struct {
	Elf32_Word	sh_name;	
	Elf32_Word	sh_type;	
	Elf32_Word	sh_flags;	
	Elf32_Addr	sh_addr;	
	Elf32_Off	sh_offset;	
	Elf32_Word	sh_size;	
	Elf32_Word	sh_link;	
	Elf32_Word	sh_info;	
	Elf32_Word	sh_addralign;	
	Elf32_Word	sh_entsize;	
} Elf32_Shdr;
typedef struct {
	Elf32_Word	p_type;		
	Elf32_Off	p_offset;	
	Elf32_Addr	p_vaddr;	
	Elf32_Addr	p_paddr;	
	Elf32_Word	p_filesz;	
	Elf32_Word	p_memsz;	
	Elf32_Word	p_flags;	
	Elf32_Word	p_align;	
} Elf32_Phdr;
typedef struct {
	Elf32_Sword	d_tag;		
	union {
		Elf32_Word	d_val;	
		Elf32_Addr	d_ptr;	
	} d_un;
} Elf32_Dyn;
typedef struct {
	Elf32_Addr	r_offset;	
	Elf32_Word	r_info;		
} Elf32_Rel;
typedef struct {
	Elf32_Addr	r_offset;	
	Elf32_Word	r_info;		
	Elf32_Sword	r_addend;	
} Elf32_Rela;
#define ELF32_R_SYM(info)	((info) >> 8)
#define ELF32_R_TYPE(info)	((unsigned char)(info))
#define ELF32_R_INFO(sym, type)	(((sym) << 8) + (unsigned char)(type))
typedef Elf_Note Elf32_Nhdr;
typedef struct {
	Elf32_Lword	m_value;	
	Elf32_Word 	m_info;		
	Elf32_Word	m_poffset;	
	Elf32_Half	m_repeat;	
	Elf32_Half	m_stride;	
} Elf32_Move;
#define	ELF32_M_SYM(info)	((info)>>8)
#define	ELF32_M_SIZE(info)	((unsigned char)(info))
#define	ELF32_M_INFO(sym, size)	(((sym)<<8)+(unsigned char)(size))
typedef struct {
	Elf32_Word	c_tag;		
	union {
		Elf32_Word	c_val;
		Elf32_Addr	c_ptr;
	} c_un;
} Elf32_Cap;
typedef struct {
	Elf32_Word	st_name;	
	Elf32_Addr	st_value;	
	Elf32_Word	st_size;	
	unsigned char	st_info;	
	unsigned char	st_other;	
	Elf32_Half	st_shndx;	
} Elf32_Sym;
#define ELF32_ST_BIND(info)		((info) >> 4)
#define ELF32_ST_TYPE(info)		((info) & 0xf)
#define ELF32_ST_INFO(bind, type)	(((bind) << 4) + ((type) & 0xf))
#define ELF32_ST_VISIBILITY(oth)	((oth) & 0x3)
typedef struct
{
	Elf32_Half	vd_version;
	Elf32_Half	vd_flags;
	Elf32_Half	vd_ndx;
	Elf32_Half	vd_cnt;
	Elf32_Word	vd_hash;
	Elf32_Word	vd_aux;
	Elf32_Word	vd_next;
} Elf32_Verdef;
typedef struct
{
	Elf32_Word	vda_name;
	Elf32_Word	vda_next;
} Elf32_Verdaux;
typedef struct
{
	Elf32_Half	vn_version;
	Elf32_Half	vn_cnt;
	Elf32_Word	vn_file;
	Elf32_Word	vn_aux;
	Elf32_Word	vn_next;
} Elf32_Verneed;
typedef struct
{
	Elf32_Word	vna_hash;
	Elf32_Half	vna_flags;
	Elf32_Half	vna_other;
	Elf32_Word	vna_name;
	Elf32_Word	vna_next;
} Elf32_Vernaux;
typedef Elf32_Half Elf32_Versym;
typedef struct {
	Elf32_Half	si_boundto;	
	Elf32_Half	si_flags;	
} Elf32_Syminfo;
#endif 
