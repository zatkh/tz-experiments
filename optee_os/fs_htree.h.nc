#ifndef __TEE_FS_HTREE_H
#define __TEE_FS_HTREE_H
#include <tee_api_types.h>
#include <utee_defines.h>
#define TEE_FS_HTREE_HASH_SIZE		TEE_SHA256_HASH_SIZE
#define TEE_FS_HTREE_IV_SIZE		16
#define TEE_FS_HTREE_FEK_SIZE		16
#define TEE_FS_HTREE_TAG_SIZE		16
struct tee_fs_htree_node_image {
	uint8_t hash[TEE_FS_HTREE_HASH_SIZE];
	uint8_t iv[TEE_FS_HTREE_IV_SIZE];
	uint8_t tag[TEE_FS_HTREE_TAG_SIZE];
	uint16_t flags;
};
struct tee_fs_htree_meta {
	uint64_t length;
};
struct tee_fs_htree_imeta {
	struct tee_fs_htree_meta meta;
	uint32_t max_node_id;
};
struct tee_fs_htree_image {
	uint8_t iv[TEE_FS_HTREE_IV_SIZE];
	uint8_t tag[TEE_FS_HTREE_TAG_SIZE];
	uint8_t enc_fek[TEE_FS_HTREE_FEK_SIZE];
	uint8_t imeta[sizeof(struct tee_fs_htree_imeta)];
	uint32_t counter;
};
enum tee_fs_htree_type {
	TEE_FS_HTREE_TYPE_HEAD,
	TEE_FS_HTREE_TYPE_NODE,
	TEE_FS_HTREE_TYPE_BLOCK,
};
struct tee_fs_rpc_operation;
struct tee_fs_htree_storage {
	size_t block_size;
	TEE_Result (*rpc_read_init)(void *aux, struct tee_fs_rpc_operation *op,
				    enum tee_fs_htree_type type, size_t idx,
				    uint8_t vers, void **data);
	TEE_Result (*rpc_read_final)(struct tee_fs_rpc_operation *op,
				     size_t *bytes);
	TEE_Result (*rpc_write_init)(void *aux, struct tee_fs_rpc_operation *op,
				     enum tee_fs_htree_type type, size_t idx,
				     uint8_t vers, void **data);
	TEE_Result (*rpc_write_final)(struct tee_fs_rpc_operation *op);
};
struct tee_fs_htree;
TEE_Result tee_fs_htree_open(bool create, uint8_t *hash, const TEE_UUID *uuid,
			     const struct tee_fs_htree_storage *stor,
			     void *stor_aux, struct tee_fs_htree **ht);
void tee_fs_htree_close(struct tee_fs_htree **ht);
struct tee_fs_htree_meta *tee_fs_htree_get_meta(struct tee_fs_htree *ht);
void tee_fs_htree_meta_set_dirty(struct tee_fs_htree *ht);
TEE_Result tee_fs_htree_sync_to_storage(struct tee_fs_htree **ht,
					uint8_t *hash);
TEE_Result tee_fs_htree_truncate(struct tee_fs_htree **ht, size_t block_num);
TEE_Result tee_fs_htree_write_block(struct tee_fs_htree **ht, size_t block_num,
				    const void *block);
TEE_Result tee_fs_htree_read_block(struct tee_fs_htree **ht, size_t block_num,
				   void *block);
#endif 
