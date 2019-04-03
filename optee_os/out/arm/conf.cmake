# auto-generated TEE configuration file
# TEE version e1a683f62-dev
set(CFG_AES_GCM_TABLE_BASED y)
set(CFG_ARM64_core y)
set(CFG_ARM64_ta_arm64 y)
# CFG_BOOT_SECONDARY_REQUEST is not set 
set(CFG_CORE_BIGNUM_MAX_BITS 4096)
set(CFG_CORE_CLUSTER_SHIFT 2)
set(CFG_CORE_HEAP_SIZE 65536)
# CFG_CORE_LARGE_PHYS_ADDR is not set 
# CFG_CORE_RODATA_NOEXEC is not set 
set(CFG_CORE_RWDATA_NOEXEC y)
# CFG_CORE_SANITIZE_KADDRESS is not set 
# CFG_CORE_SANITIZE_UNDEFINED is not set 
set(CFG_CORE_TZSRAM_EMUL_SIZE 458752)
set(CFG_CORE_UNMAP_CORE_AT_EL0 y)
set(CFG_CORE_WORKAROUND_SPECTRE_BP y)
set(CFG_CORE_WORKAROUND_SPECTRE_BP_SEC y)
set(CFG_CRYPTO y)
set(CFG_CRYPTOLIB_DIR core/lib/libtomcrypt)
set(CFG_CRYPTOLIB_NAME tomcrypt)
set(CFG_CRYPTO_AES y)
# CFG_CRYPTO_AES_GCM_FROM_CRYPTOLIB is not set 
set(CFG_CRYPTO_CBC y)
set(CFG_CRYPTO_CBC_MAC y)
set(CFG_CRYPTO_CCM y)
set(CFG_CRYPTO_CMAC y)
set(CFG_CRYPTO_CONCAT_KDF y)
set(CFG_CRYPTO_CTR y)
set(CFG_CRYPTO_CTS y)
set(CFG_CRYPTO_DES y)
set(CFG_CRYPTO_DH y)
set(CFG_CRYPTO_DSA y)
set(CFG_CRYPTO_ECB y)
set(CFG_CRYPTO_ECC y)
set(CFG_CRYPTO_GCM y)
set(CFG_CRYPTO_HKDF y)
set(CFG_CRYPTO_HMAC y)
set(CFG_CRYPTO_MD5 y)
set(CFG_CRYPTO_PBKDF2 y)
set(CFG_CRYPTO_RSA y)
set(CFG_CRYPTO_SHA1 y)
set(CFG_CRYPTO_SHA224 y)
set(CFG_CRYPTO_SHA256 y)
set(CFG_CRYPTO_SHA384 y)
set(CFG_CRYPTO_SHA512 y)
set(CFG_CRYPTO_SIZE_OPTIMIZATION y)
set(CFG_CRYPTO_XTS y)
set(CFG_DT y)
set(CFG_DTB_MAX_SIZE 0x10000)
set(CFG_DYN_SHM_CAP y)
# CFG_EARLY_TA is not set 
# CFG_ENABLE_SCTLR_RR is not set 
# CFG_ENABLE_SCTLR_Z is not set 
set(CFG_GENERIC_BOOT y)
set(CFG_GIC y)
set(CFG_GP_SOCKETS y)
set(CFG_HWSUPP_MEM_PERM_PXN y)
set(CFG_HWSUPP_MEM_PERM_WXN y)
set(CFG_KERN_LINKER_ARCH aarch64)
set(CFG_KERN_LINKER_FORMAT elf64-littleaarch64)
set(CFG_LIBUTILS_WITH_ISOC y)
set(CFG_LPAE_ADDR_SPACE_SIZE (1ull << 32))
set(CFG_LTC_OPTEE_THREAD y)
set(CFG_MMAP_REGIONS 13)
set(CFG_MSG_LONG_PREFIX_MASK 0x1a)
set(CFG_NUM_THREADS 2)
set(CFG_OPTEE_REVISION_MAJOR 3)
set(CFG_OPTEE_REVISION_MINOR 1)
set(CFG_OS_REV_REPORTS_GIT_SHA1 y)
# CFG_PAGED_USER_TA is not set 
set(CFG_PL011 y)
set(CFG_PM_DEBUG 0)
set(CFG_PM_STUBS y)
set(CFG_REE_FS y)
set(CFG_REE_FS_TA y)
set(CFG_RESERVED_VASPACE_SIZE (1024 * 1024 * 10))
# CFG_RPMB_FS is not set 
set(CFG_RPMB_FS_DEV_ID 0)
# CFG_RPMB_WRITE_KEY is not set 
set(CFG_SCTLR_ALIGNMENT_CHECK y)
set(CFG_SECSTOR_TA y)
set(CFG_SECSTOR_TA_MGMT_PTA y)
# CFG_SECURE_DATA_PATH is not set 
set(CFG_SECURE_TIME_SOURCE_CNTPCT y)
set(CFG_SHMEM_SIZE 0x00200000)
set(CFG_SHMEM_START 0x42000000)
set(CFG_TA_BIGNUM_MAX_BITS 2048)
set(CFG_TA_DYNLINK y)
set(CFG_TA_FLOAT_SUPPORT y)
# CFG_TA_GPROF_SUPPORT is not set 
set(CFG_TA_MBEDTLS y)
set(CFG_TA_MBEDTLS_SELF_TEST y)
set(CFG_TA_PTA_TEST y)
set(CFG_TEE_API_VERSION GPD-1.1-dev)
# CFG_TEE_BENCHMARK is not set 
set(CFG_TEE_CORE_DEBUG y)
set(CFG_TEE_CORE_EMBED_INTERNAL_TESTS y)
set(CFG_TEE_CORE_LOG_LEVEL 4)
# CFG_TEE_CORE_MALLOC_DEBUG is not set 
set(CFG_TEE_CORE_NB_CORE 2)
set(CFG_TEE_CORE_TA_TRACE y)
set(CFG_TEE_FW_IMPL_VERSION FW_IMPL_UNDEF)
set(CFG_TEE_FW_MANUFACTURER FW_MAN_UNDEF)
set(CFG_TEE_IMPL_DESCR OPTEE)
set(CFG_TEE_MANUFACTURER LINARO)
set(CFG_TEE_RAM_VA_SIZE 0x00100000)
set(CFG_TEE_SDP_MEM_SIZE 0x00100000 )
set(CFG_TEE_TA_LOG_LEVEL 4)
# CFG_TEE_TA_MALLOC_DEBUG is not set 
set(CFG_TZDRAM_SIZE 0x00f00000 )
set(CFG_TZDRAM_START 0x0e100000)
# CFG_ULIBS_GPROF is not set 
set(CFG_UNWIND y)
set(CFG_WITH_ARM_TRUSTED_FW y)
set(CFG_WITH_LPAE y)
# CFG_WITH_PAGER is not set 
set(CFG_WITH_SOFTWARE_PRNG y)
set(CFG_WITH_STACK_CANARIES y)
set(CFG_WITH_STATS y)
set(CFG_WITH_USER_TA y)
set(CFG_WITH_VFP y)
set(PLATFORM_FLAVOR qemu_armv8a)
set(PLATFORM_FLAVOR_qemu_armv8a y)
set(PLATFORM_vexpress y)
set(_CFG_CRYPTO_WITH_ACIPHER y)
set(_CFG_CRYPTO_WITH_ASN1 y)
set(_CFG_CRYPTO_WITH_AUTHENC y)
set(_CFG_CRYPTO_WITH_CBC y)
set(_CFG_CRYPTO_WITH_CIPHER y)
set(_CFG_CRYPTO_WITH_FORTUNA_PRNG y)
set(_CFG_CRYPTO_WITH_HASH y)
set(_CFG_CRYPTO_WITH_MAC y)
