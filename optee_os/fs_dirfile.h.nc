#ifndef __TEE_FS_DIRFILE_H
#define __TEE_FS_DIRFILE_H
#include <tee/tee_fs.h>
#include <tee/fs_htree.h>
struct tee_fs_dirfile_dirh;
struct tee_fs_dirfile_fileh {
	uint32_t file_number;
	uint8_t hash[TEE_FS_HTREE_HASH_SIZE];
	int idx;
};
struct tee_fs_dirfile_operations {
	TEE_Result (*open)(bool create, uint8_t *hash, const TEE_UUID *uuid,
			   struct tee_fs_dirfile_fileh *dfh,
			   struct tee_file_handle **fh);
	void (*close)(struct tee_file_handle *fh);
	TEE_Result (*read)(struct tee_file_handle *fh, size_t pos,
			   void *buf, size_t *len);
	TEE_Result (*write)(struct tee_file_handle *fh, size_t pos,
			    const void *buf, size_t len);
	TEE_Result (*commit_writes)(struct tee_file_handle *fh, uint8_t *hash);
};
TEE_Result tee_fs_dirfile_open(bool create, uint8_t *hash,
			       const struct tee_fs_dirfile_operations *fops,
			       struct tee_fs_dirfile_dirh **dirh);
void tee_fs_dirfile_close(struct tee_fs_dirfile_dirh *dirh);
TEE_Result tee_fs_dirfile_commit_writes(struct tee_fs_dirfile_dirh *dirh,
					uint8_t *hash);
TEE_Result tee_fs_dirfile_get_tmp(struct tee_fs_dirfile_dirh *dirh,
				  struct tee_fs_dirfile_fileh *dfh);
TEE_Result tee_fs_dirfile_find(struct tee_fs_dirfile_dirh *dirh,
			       const TEE_UUID *uuid, const void *oid,
			       size_t oidlen, struct tee_fs_dirfile_fileh *dfh);
TEE_Result tee_fs_dirfile_fileh_to_fname(const struct tee_fs_dirfile_fileh *dfh,
					 char *fname, size_t *fnlen);
TEE_Result tee_fs_dirfile_rename(struct tee_fs_dirfile_dirh *dirh,
				 const TEE_UUID *uuid,
				 struct tee_fs_dirfile_fileh *dfh,
				 const void *oid, size_t oidlen);
TEE_Result tee_fs_dirfile_remove(struct tee_fs_dirfile_dirh *dirh,
				 const struct tee_fs_dirfile_fileh *dfh);
TEE_Result tee_fs_dirfile_update_hash(struct tee_fs_dirfile_dirh *dirh,
				      const struct tee_fs_dirfile_fileh *dfh);
TEE_Result tee_fs_dirfile_get_next(struct tee_fs_dirfile_dirh *dirh,
				   const TEE_UUID *uuid, int *idx, void *oid,
				   size_t *oidlen);
#endif 
