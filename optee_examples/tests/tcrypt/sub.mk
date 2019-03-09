global-incdirs-y += include

srcs-y += tcrypt.c
srcs-y += chacha.c
srcs-y += blake2b-ref.c
srcs-y += blake2bp-ref.c
srcs-y += blake2s-ref.c
srcs-y += blake2sp-ref.c
srcs-y += blake2xb-ref.c
srcs-y += blake2xs-ref.c
srcs-y += csiphash.c
srcs-y += poly1305-donna.c
#srcs-y += poly1305.c
# To remove a certain compiler flag, add a line like this
#cflags-template_ta.c-y += -Wno-strict-prototypes
