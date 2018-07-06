# -*- mode: makefile-gmake -*-

# Default build rule for any Makefile in this project: all
default: all

OS := $(shell uname)

PREFIX =arm-none-eabi-
AS = $(PREFIX)as
CC = $(PREFIX)gcc
LD = $(PREFIX)ld
AR = $(PREFIX)ar
OBJCOPY = $(PREFIX)objcopy
LIBGCC = $(shell $(CC) -print-libgcc-file-name)


CFLAGS_add += -fno-gnu89-inline -fno-builtin

ARCH = aarch64
CFLAGS_add += -mhard-float



# If CFLAGS does not contain a -O optimization flag, default to -O3
ifeq ($(findstring -O,$(CFLAGS)),)
CFLAGS_add += -O3
endif



# Add `-march` to our CFLAGS if it's defined
ifneq ($(MARCH),)
CFLAGS_arch += -march=$(MARCH)
endif




# Add our "arch"-related FLAGS in.  We separate arch-related flags out so that
# we can conveniently get at them for targets that don't want the rest of
# *FLAGS_add, such as the testing Makefile targets
CFLAGS_add  += $(CFLAGS_arch)
SFLAGS_add  += $(SFLAGS_arch)
LDFLAGS_add += $(LDFLAGS_arch)

CFLAGS_add += -std=c99 -Wall -I$(OPENLIBM_HOME) -I$(OPENLIBM_HOME)/include -I$(OPENLIBM_HOME)/$(ARCH) -I$(OPENLIBM_HOME)/src -DASSEMBLER -D__BSD_VISIBLE -Wno-implicit-function-declaration
ifneq ($(filter $(ARCH),i387 amd64 aarch64 powerpc),)
CFLAGS_add += -I$(OPENLIBM_HOME)/ld80
endif


# *int / *intf need to be built with -O0
src/%int.c.o: src/%int.c
	$(CC) $(CPPFLAGS) -O0 $(CFLAGS_add) -c $< -o $@

src/%intf.c.o: src/%intf.c
	$(CC) $(CPPFLAGS) -O0 $(CFLAGS_add) -c $< -o $@

%.c.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_add) -c $< -o $@

%.S.o: %.S
	$(CC) $(CPPFLAGS) $(SFLAGS) $(SFLAGS_add) $(filter -m% -B% -I% -D%,$(CFLAGS_add)) -c $< -o $@


# Makefile debugging trick:
# call print-VARIABLE to see the runtime value of any variable
print-%:
	@echo '$*=$($*)'
