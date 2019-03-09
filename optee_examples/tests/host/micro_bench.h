#ifndef MICORO_BENCH_H
#define MICORO_BENCH_H

void init_latency(void);
void init_latency_seperatly(void);
void tfs_latency(void);
void ecall_puts_latency(void* buf, size_t buf_len);
void hello_file_bench(void);
void ecall_hello_fle_bench(void);
void tfs_syscalls_latency(void);
void test_file (void);
void ecall_console_bench(void);
int ecall_open_bench(const char *name);
int ecall_write_bench(int fd, void * buf, size_t len);
int ecall_read_bench(int fd, void * buf, size_t len);
void pta_round_bench(void);
#endif //MICORO_BENCH_H
