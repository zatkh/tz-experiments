#include <bmfs/dir.h>
#include <bmfs/errno.h>
#include <bmfs/fs.h>
#include <bmfs/file.h>
#include <bmfs/limits.h>
#include <bmfs/ramdisk.h>
#include <bmfs/encoding.h>

#include <stdlib.h>
#include <string.h>

#include "bmfs_assert.h"
#define DEBUG_PRINTF 1

/* Allocate memory for ramdisk */
size_t buf_size = BMFS_MINIMUM_DISK_SIZE;
void *ramdisk_buf;
/* Setup the file system structure. */
struct BMFS fs;
/* Setup the ramdisk */
struct BMFSRamdisk ramdisk;
struct BMFSFile bmfs_file;
const char* file_name="/tmp/test.txt";
char wbuf[] = "this is a fucking test";
bmfs_uint64 wbuf_size=sizeof(wbuf);


static bmfs_bool test_encoding64(bmfs_uint64 n, const void *buf)
{
	unsigned char out[8];
	printf("test_encoding64\n");

	bmfs_encode_uint64(n, out);

	if (memcmp(out, buf, 8) == 0)
		return BMFS_TRUE;
	else
		return BMFS_FALSE;
}

static bmfs_bool test_encoding32(bmfs_uint32 n, const void *buf)
{
	unsigned char out[4];
	printf("test_encoding64\n");

	bmfs_encode_uint32(n, out);

	if (memcmp(out, buf, 4) == 0)
		return BMFS_TRUE;
	else
		return BMFS_FALSE;
}


int bmfs_init_test()
{
	ramdisk_buf= malloc(buf_size);
	bmfs_assert(ramdisk_buf != NULL);

	bmfs_ramdisk_init(&ramdisk);

	int err = bmfs_ramdisk_set_buf(&ramdisk, ramdisk_buf, buf_size);
	bmfs_assert(err == 0);

	bmfs_init(&fs);

	bmfs_set_disk(&fs, &ramdisk.base);

	/* Format the disk. */

	err = bmfs_format(&fs, buf_size);
	bmfs_assert(err == 0);

	/* Test the creation of directories */

	err = bmfs_create_dir(&fs, "/tmp");
	bmfs_assert(err == 0);

	return 0;

}
int fs_test(void)
{
	
	void *buf = malloc(buf_size);
	bmfs_assert(buf != NULL);

	bmfs_ramdisk_init(&ramdisk);

	int err = bmfs_ramdisk_set_buf(&ramdisk, buf, buf_size);
	bmfs_assert(err == 0);

	bmfs_init(&fs);

	bmfs_set_disk(&fs, &ramdisk.base);

	/* Format the disk. */

	err = bmfs_format(&fs, buf_size);
	bmfs_assert(err == 0);

	/* Test the creation of directories */

	err = bmfs_create_dir(&fs, "/tmp");
	bmfs_assert(err == 0);

	err = bmfs_create_dir(&fs, "/usr");
	bmfs_assert(err == 0);

	err = bmfs_create_dir(&fs, "/home");
	bmfs_assert(err == 0);

	/* Test the creation of files */

	err = bmfs_create_file(&fs, "/tmp/a.txt");
	bmfs_assert(err == 0);

	err = bmfs_create_file(&fs, "/tmp/b.txt");
	bmfs_assert(err == 0);

	if(err != 0)
	printf("failed to create file \n");
	else
	printf("created the file wow %s\n","/tmp/b.txt");

	
	bmfs_file_init(&bmfs_file);

	//bmfs_file.Table = fs.Table;

	err=bmfs_open_file(&fs, &bmfs_file, "/tmp/b.txt");
	if(err !=0)
		printf("failed to open file \n");
	else
		printf("opend the file wow\n");

   	bmfs_uint64 result;
    char * rbuf=  (char*) malloc (sizeof(char)*wbuf_size);

    bmfs_file_set_mode(&bmfs_file,BMFS_FILE_MODE_RW);
	printf("wbuf size %d\n",wbuf_size);
	err= bmfs_file_write(&bmfs_file,wbuf, wbuf_size,&result);
	if(err !=0)
		printf("failed to write fileerr number %d, result: %d\n",err, result);
	else
		printf("wrtite to the file wow\n");

	err= bmfs_file_seek(&bmfs_file,0,BMFS_SEEK_SET);
	if(err !=0)
		printf("failed to seek file to 0 number : err %d\n",err);
	else
		printf("seek to 0 to the file wow\n");
	err= bmfs_file_read(&bmfs_file,rbuf,wbuf_size,&result);	

	if(err !=0)
		printf("failed to read fileerr number %d, result: %d\n",err, result);
	else
		printf("read to the file wow, rbuf: %s\n", rbuf);
	/* Test that the same file can't be created twice. */

	err = bmfs_create_file(&fs, "/tmp/a.txt");
	bmfs_assert(err == BMFS_EEXIST);

	/* Test the creation of subdirectories. */

	err = bmfs_create_dir(&fs, "/usr/local");
	bmfs_assert(err == 0);

	/* Test that files can't be created in
	 * directories that aren't there */

	err = bmfs_create_file(&fs, "/tmp2/b.txt");
	bmfs_assert(err != 0);


	/* Test that the same directory can't be created twice. */

	err = bmfs_create_dir(&fs, "/usr/local");
	bmfs_assert(err == BMFS_EEXIST);

	/* Test that directories can be opened. */

	struct BMFSDir dir;

	bmfs_dir_init(&dir);

	err = bmfs_open_dir(&fs, &dir, "/");

	bmfs_assert(err == 0);

	const struct BMFSEntry *entry = bmfs_dir_next(&dir);
	bmfs_assert(entry != NULL);
	bmfs_assert(strcmp(entry->Name, "tmp") == 0);
	bmfs_assert(bmfs_entry_is_directory(entry));

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry != NULL);
	bmfs_assert(strcmp(entry->Name, "usr") == 0);
	bmfs_assert(bmfs_entry_is_directory(entry));

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry != NULL);
	bmfs_assert(strcmp(entry->Name, "home") == 0);
	bmfs_assert(bmfs_entry_is_directory(entry));

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry == NULL);

	/* Test that subdirectories can be opened. */

	err = bmfs_open_dir(&fs, &dir, "/usr");
	bmfs_assert(err == 0);

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry != NULL);
	bmfs_assert(strcmp(entry->Name, "local") == 0);
	bmfs_assert(bmfs_entry_is_directory(entry));

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry == NULL);

	err = bmfs_open_dir(&fs, &dir, "/tmp");
	bmfs_assert(err == 0);

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry != NULL);
	bmfs_assert(strcmp(entry->Name, "a.txt") == 0);
	bmfs_assert(bmfs_entry_is_file(entry));

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry != NULL);
	bmfs_assert(strcmp(entry->Name, "b.txt") == 0);
	bmfs_assert(bmfs_entry_is_file(entry));

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry == NULL);

	/* Test to ensure that the entire file name is checked. */

	err = bmfs_open_dir(&fs, &dir, "/us");
	bmfs_assert(err == BMFS_ENOENT);

	/* Test that the empty directories don't contain anything. */

	err = bmfs_open_dir(&fs, &dir, "/home");
	bmfs_assert(err == 0);

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry == NULL);

	err = bmfs_open_dir(&fs, &dir, "/usr/local");
	bmfs_assert(err == 0);

	entry = bmfs_dir_next(&dir);
	bmfs_assert(entry == NULL);

	free(buf);

	return 0;
}

int bmfs_create_del_file_test()
{
	int err = bmfs_create_file(&fs, "/tmp/test.txt");
	bmfs_assert(err == 0);
	if(err != 0 && DEBUG_PRINTF)
		{
			printf("[bmfs_create_del_file_test]failed to create file \n");
			return -1;
		}
	else
		printf("[bmfs_create_del_file_test]created the file %s\n","/tmp/test.txt");

	err= bmfs_delete_file(&fs, "/tmp/test.txt");	
	if(err != 0 && DEBUG_PRINTF)
		{
			printf("[bmfs_create_del_file_test]failed to delete file \n");
			return -1;
		}
	else
		printf("[bmfs_create_del_file_test]deleted the file %s\n","/tmp/test.txt");

	return 0;	
}

int bmfs_create_file_test()
{
	int err = bmfs_create_file(&fs, file_name);
	bmfs_assert(err == 0);
	if(err != 0 && DEBUG_PRINTF)
		{
			printf("[bmfs_create_del_file_test]failed to create file %s \n", file_name);
			return -1;
		}
	else
		printf("[bmfs_create_del_file_test]created the file %s\n",file_name);

	return 0;	
}

int bmfs_delete_file_test()
{
	
	int err= bmfs_delete_file(&fs, file_name);	
	if(err != 0 && DEBUG_PRINTF)
		{
			printf("[bmfs_create_del_file_test]failed to delete file %s \n", file_name);
			return -1;
		}
	else
		printf("[bmfs_create_del_file_test]deleted the file %s\n",file_name);

	return 0;	
}

int bmfs_open_file_test(void)
{

	int err=bmfs_open_file(&fs, &bmfs_file, file_name);
	/*
	if(err !=0 && DEBUG_PRINTF)
		{
			printf("[bmfs_open_file_test]failed to open file %s \n", file_name);
			return -1;
		}
	else
		printf("[bmfs_open_file_test]opend the file yay %s\n", file_name);
*/
    bmfs_file_set_mode(&bmfs_file,BMFS_FILE_MODE_RW);

	return 0;

}

int bmfs_write_file_test(void)
{

	bmfs_uint64 result;
	int err= bmfs_file_write(&bmfs_file,wbuf, wbuf_size,&result);
/*
	if(err !=0 )
		return -1;
	else 
	*/
		return 0;

}

int bmfs_read_file_test(void)
{
   	bmfs_uint64 result;
    char * rbuf=  (char*) malloc (sizeof(char)*wbuf_size);
	int err= bmfs_file_read(&bmfs_file,rbuf,wbuf_size,&result);	
/*
	if(err !=0 )
		return -1;
	else 
		printf("[bmfs_read_file_test]read to the file wow, rbuf: %s\n", rbuf);
		return 0;

	if(err !=0 && DEBUG_PRINTF)
		printf("[bmfs_read_file_test]failed to read fileerr number %d, result: %d\n",err, result);
	else
		printf("[bmfs_read_file_test]read to the file wow, rbuf: %s\n", rbuf);

	return 0;	

*/
return 0;

}

int bmfs_seek_file_test(void)
{
	int err= bmfs_file_seek(&bmfs_file,0,BMFS_SEEK_SET);
	/*if(err !=0 )
		return -1;
	else 
		return 0;
		*/
	return 0;

}
void bmfs_close_file_test()
{
	bmfs_file_close(&bmfs_file);

}
int bmfs_test(void)
{

 	printf("fs test start\n");
	int ret=bmfs_init_test();
	bmfs_file_init(&bmfs_file);
	#ifdef DEBUG_PRINTF
	printf("fs test end, ret: %d \n", ret);
	#endif
	ret=bmfs_create_del_file_test();
	#ifdef DEBUG_PRINTF
	printf("fs create file test end, ret: %d \n", ret);
	#endif

	int i=0;
	ret=bmfs_create_file_test();
	ret=bmfs_open_file_test();
	for(i;i<10;i++)
	ret=bmfs_write_file_test();
	ret=bmfs_seek_file_test();
	i=0;
	for(i;i<10;i++)
	ret=bmfs_read_file_test();

	//int ret=fs_test();
	

	//bmfs_assert(test_encoding64(0x1122334455667788, "\x88\x77\x66\x55\x44\x33\x22\x11"));
	//bmfs_assert(test_encoding32(0xaabbccdd, "\xdd\xcc\xbb\xaa"));


	return 0;

}

void bmfs_cleanup(void)
{
	bmfs_delete_file_test();	
	free(ramdisk_buf);


}

