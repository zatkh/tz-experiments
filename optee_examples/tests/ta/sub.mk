global-incdirs-y += include

srcs-y += main_ta.c ocaml.c
#srcs-y += test_bmfs.c
srcs-y += test_libm.c
#srcs-y += storage.c
srcs-y += ta_storage.c


# To remove a certain compiler flag, add a line like this
#cflags-template_ta.c-y += -Wno-strict-prototypes
