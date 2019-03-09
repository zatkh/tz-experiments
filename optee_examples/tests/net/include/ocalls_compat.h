#ifndef OCALLS_COMAPT_H
#define OCALLS_COMAPT_H
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <tee_internal_api.h>
#include <tee_internal_api_extensions.h>
#include "../common/common.h"



TEE_Result snape_driver_open(void);
void snape_driver_close(void);
int usleep(int micorsec);
int close(int fd);
int tap_open(const char *name);
//ssize_t read(int, void *, size_t);
//ssize_t write(int, const void *, size_t);
#endif //OCALLS_COMAPT_H