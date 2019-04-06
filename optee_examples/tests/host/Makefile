CC      ?= $(CROSS_COMPILE)gcc
LD      ?= $(CROSS_COMPILE)ld
AR      ?= $(CROSS_COMPILE)ar
NM      ?= $(CROSS_COMPILE)nm
OBJCOPY ?= $(CROSS_COMPILE)objcopy
OBJDUMP ?= $(CROSS_COMPILE)objdump
READELF ?= $(CROSS_COMPILE)readelf

OBJS = main_host.o secure_fs_interface.o ocaml.o#micro_bench.o

OBJS+= libcamlrun_byte/interp.o libcamlrun_byte/misc.o libcamlrun_byte/stacks.o libcamlrun_byte/fix_code.o libcamlrun_byte/startup_aux.o libcamlrun_byte/startup.o \
	libcamlrun_byte/freelist.o libcamlrun_byte/major_gc.o libcamlrun_byte/minor_gc.o libcamlrun_byte/memory.o libcamlrun_byte/alloc.o libcamlrun_byte/roots.o libcamlrun_byte/globroots.o \
	libcamlrun_byte/fail.o libcamlrun_byte/signals.o libcamlrun_byte/signals_byt.o libcamlrun_byte/printexc.o libcamlrun_byte/backtrace_prim.o libcamlrun_byte/backtrace.o \
	libcamlrun_byte/compare.o libcamlrun_byte/ints.o libcamlrun_byte/floats.o libcamlrun_byte/str.o libcamlrun_byte/array.o libcamlrun_byte/io.o libcamlrun_byte/extern.o libcamlrun_byte/intern.o \
	libcamlrun_byte/hash.o libcamlrun_byte/sys.o libcamlrun_byte/meta.o libcamlrun_byte/parsing.o libcamlrun_byte/gc_ctrl.o libcamlrun_byte/md5.o libcamlrun_byte/obj.o \
	libcamlrun_byte/lexing.o libcamlrun_byte/callback.o libcamlrun_byte/debugger.o libcamlrun_byte/weak.o libcamlrun_byte/compact.o libcamlrun_byte/finalise.o libcamlrun_byte/custom.o \
	libcamlrun_byte/dynlink.o libcamlrun_byte/spacetime.o libcamlrun_byte/afl.o libcamlrun_byte/bigarray.o libcamlrun_byte/main.o libcamlrun_byte/unix.o libcamlrun_byte/instrtrace.o 

CFLAGS += -Wall -Ilibcamlrun_byte -I../ta/include -I../net/include -I../tui/include -I../tcrypt/include -I../tfs/include -I$(TEEC_EXPORT)/include -I./include
CFLAGS += -fno-builtin -fno-builtin-printf -DCAML_NAME_SPACE -DHAS_TIMES #-DDEBUG 


CFLAGS += -Wall -O2 -g -I./
#Add/link other required libraries here
LDADD += -lteec -L$(TEEC_EXPORT)lib -lpthread -L./ -lm
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


