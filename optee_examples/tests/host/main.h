
#ifndef MAIN_H
#define MAIN_H
//enclaves headers
#include "main_ta.h"
#include "net_enclave.h"
#include "tfs_enclave.h"
#include "tcrypt_enclave.h"
#include "tui_enclave.h"
#include "secure_fs_interface.h"

#include <tee_client_api.h>


extern int tz_init(void);
//TEEC_Result init_enclaves(void);
//void destroy_enclaves(void);

#endif