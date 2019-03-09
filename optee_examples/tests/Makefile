export V?=0

# If _HOST or _TA specific compilers are not specified, then use CROSS_COMPILE
HOST_CROSS_COMPILE ?= $(CROSS_COMPILE)
TA_CROSS_COMPILE ?= $(CROSS_COMPILE)

.PHONY: all
all:
	$(MAKE) -C host CROSS_COMPILE="$(HOST_CROSS_COMPILE)" --no-builtin-variables
	$(MAKE) -C ta CROSS_COMPILE="$(TA_CROSS_COMPILE)" LDFLAGS=""
	$(MAKE) -C net CROSS_COMPILE="$(TA_CROSS_COMPILE)" LDFLAGS=""
	$(MAKE) -C tui CROSS_COMPILE="$(TA_CROSS_COMPILE)" LDFLAGS=""
	$(MAKE) -C tcrypt CROSS_COMPILE="$(TA_CROSS_COMPILE)" LDFLAGS=""
	$(MAKE) -C tfs CROSS_COMPILE="$(TA_CROSS_COMPILE)" LDFLAGS=""


.PHONY: clean
clean:
	$(MAKE) -C host clean
	$(MAKE) -C ta clean
	$(MAKE) -C net clean
	$(MAKE) -C tui clean
	$(MAKE) -C tcrypt clean
	$(MAKE) -C tfs clean


