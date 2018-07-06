OPENLIBM_HOME=.
global-incdirs-y += include
global-incdirs-y += $(OPENLIBM_HOME) $(OPENLIBM_HOME)/include $(OPENLIBM_HOME)/aarch64 $(OPENLIBM_HOME)/src $(OPENLIBM_HOME)/ld80

subdirs-y += src
subdirs-y += aarch64
subdirs-y += bsdsrc


cflags-lib-y += -DASSEMBLER -D__BSD_VISIBLE -Wno-implicit-function-declaration

#cflags-lib-y += -Wno-switch-default
#cflags-lib-$(CFG_ULIBS_GPROF) += -pg
