CC      ?= $(CROSS_COMPILE)gcc
LD      ?= $(CROSS_COMPILE)ld
AR      ?= $(CROSS_COMPILE)ar
NM      ?= $(CROSS_COMPILE)nm
OBJCOPY ?= $(CROSS_COMPILE)objcopy
OBJDUMP ?= $(CROSS_COMPILE)objdump
READELF ?= $(CROSS_COMPILE)readelf

OBJS = main.o secure_fs_interface.o ukvm_cpu_aarch64.o ukvm_hv_kvm_aarch64.o ukvm_hv_kvm.o ukvm_core.o ukvm_elf.o ukvm_module_blk.o ukvm_module_net.o micro_bench.o

CFLAGS += -Wall -I../ta/include -I../net/include -I../tui/include -I../tcrypt/include -I../tfs/include -I$(TEEC_EXPORT)/include -I./include
#CFLAGS += -I$(TA_DEV_KIT_DIR)/host_include

#UKVM_CFLAGS=-Wall -Werror -std=c99 -O2 -g  -DUKVM_MODULE_BLK -DUKVM_MODULE_NET -DUKVM_MODULE_GDB

CFLAGS += -Wall -O2 -g -DUKVM_MODULE_BLK -DUKVM_MODULE_NET -I./
#Add/link other required libraries here
LDADD += -lteec -L$(TEEC_EXPORT)lib -lpthread -L./
#Add/link other required libraries here

BINARY = optee_example_tests

.PHONY: all
all: $(BINARY)



$(BINARY): $(OBJS)
	@echo "  LD      $@"
	$(CC) -o $@ $+ $(LDADD)

%.o: %.c
	@echo '  CC      $<'
	$(CC) $(LDADD) $(CFLAGS) -c $< -o $@ 

.PHONY: clean
clean:
	rm -f $(OBJS) $(BINARY)


