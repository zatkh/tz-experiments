#ifndef SECURE_FS_INTERFACE_H
#define SECURE_FS_INTERFACE_H

#include <string.h>
#include <stdio.h>

#include <tee_client_api.h>
#include <ta_storage.h>
#include <tee_api_defines.h>
#include <tee_api_defines_extensions.h>
//#include <tee_api_types.h>

static uint32_t storage_ids[] = {
	TEE_STORAGE_PRIVATE,
#ifdef CFG_REE_FS
	TEE_STORAGE_PRIVATE_REE,
#endif
#ifdef CFG_RPMB_FS
	TEE_STORAGE_PRIVATE_RPMB,
#endif
};

static uint8_t file_00[] = {
	0x00, 0x6E, 0x04, 0x57, 0x08, 0xFB, 0x71, 0x96,
	0xF0, 0x2E, 0x55, 0x3D, 0x02, 0xC3, 0xA6, 0x92,
	0xE9, 0xC3, 0xEF, 0x8A, 0xB2, 0x34, 0x53, 0xE6,
	0xF0, 0x74, 0x9C, 0xD6, 0x36, 0xE7, 0xA8, 0x8E
};

static uint8_t file_01[] = {
	0x01, 0x00
};

static uint8_t file_02[] = {
	0x02, 0x11, 0x02
};

static uint8_t file_03[] = {
	0x03, 0x13, 0x03
};

static uint8_t file_04[] = {
	0x00, 0x01, 0x02
};

static uint8_t data_00[] = {
	0x00, 0x6E, 0x04, 0x57, 0x08, 0xFB, 0x71, 0x96,
	0x00, 0x2E, 0x55, 0x3D, 0x02, 0xC3, 0xA6, 0x92,
	0x00, 0xC3, 0xEF, 0x8A, 0xB2, 0x34, 0x53, 0xE6,
	0x00, 0x74, 0x9C, 0xD6, 0x36, 0xE7, 0xA8, 0x00
};

static uint8_t data_01[] = {
	0x01, 0x6E, 0x04, 0x57, 0x08, 0xFB, 0x71, 0x96,
	0x01, 0x2E, 0x55, 0x3D, 0x02, 0xC3, 0xA6, 0x92,
	0x01, 0xC3, 0xEF, 0x8A, 0xB2, 0x34, 0x53, 0xE6,
	0x01, 0x74, 0x9C, 0xD6, 0x36, 0xE7, 0xA8, 0x01
};

//fs funcs:
bool storage_is(uint32_t id1, uint32_t id2);
TEEC_Result fs_open(TEEC_Session *sess, void *id, 
                            uint32_t id_size,uint32_t flags, uint32_t *obj, 
                            uint32_t storage_id);

TEEC_Result fs_create(TEEC_Session *sess, void *id, uint32_t id_size,
			     uint32_t flags, uint32_t attr, void *data,
			     uint32_t data_size, uint32_t *obj,
			     uint32_t storage_id);

TEEC_Result fs_close(TEEC_Session *sess, uint32_t obj);
                
TEEC_Result fs_create_overwrite(TEEC_Session *sess, void *id,
				       uint32_t id_size, uint32_t storage_id);

TEEC_Result fs_read(TEEC_Session *sess, uint32_t obj, void *data,
			   uint32_t data_size, uint32_t *count);

TEEC_Result fs_write(TEEC_Session *sess, uint32_t obj, void *data,
			    uint32_t data_size); 

TEEC_Result fs_seek(TEEC_Session *sess, uint32_t obj, int32_t offset,
			   int32_t whence);    

TEEC_Result fs_unlink(TEEC_Session *sess, uint32_t obj);     

 TEEC_Result fs_trunc(TEEC_Session *sess, uint32_t obj, uint32_t len);

 TEEC_Result fs_rename(TEEC_Session *sess, uint32_t obj, void *id,
			     uint32_t id_size);

 TEEC_Result fs_alloc_enum(TEEC_Session *sess, uint32_t *e);

 TEEC_Result fs_reset_enum(TEEC_Session *sess, uint32_t e);

 TEEC_Result fs_free_enum(TEEC_Session *sess, uint32_t e);

 TEEC_Result fs_start_enum(TEEC_Session *sess, uint32_t e,
				 uint32_t storage_id);
 TEEC_Result fs_next_enum(TEEC_Session *sess, uint32_t e, void *obj_info,
				size_t info_size, void *id, uint32_t id_size);

 TEEC_Result fs_restrict_usage(TEEC_Session *sess, uint32_t obj,
				     uint32_t obj_usage);

 TEEC_Result fs_alloc_obj(TEEC_Session *sess, uint32_t obj_type,
				     uint32_t max_key_size, uint32_t *obj);

 TEEC_Result fs_free_obj(TEEC_Session *sess, uint32_t obj);

 TEEC_Result fs_reset_obj(TEEC_Session *sess, uint32_t obj);

 TEEC_Result fs_get_obj_info(TEEC_Session *sess, uint32_t obj,
				void *obj_info, size_t info_size);

                                  
#endif //SECURE_FS_INTERFACE_H