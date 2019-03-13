# Some Sample Applications

## 2. List of sample applications


Directory **tests/**:
* A simple sample code shows comnications between Normal and Secure world, there are two enclaves, one (TEST_ENCLAVE)running as secure kernel driver , the other one (HELLO_ENCLAVE) as a process on secure world userspace. This is just to show how the interaction/RPCs work.
tests/host is the NW side of the application, ather directories are enclaves doing difffrent things. The HELLO_ENCLAVE ocde is in tests/ta and the TEST_ENCLAVE is in optee/os/arch/arm/pta/enclave-test-driver.c where you can see how RPCs are used to access syscalls from NW.

* Basic RPCs details for comminicating with secure world from normal world: optee_client/public/tee_client_api.h

* RPCs are implmeneted as part of the secure world OS kernel optee_os/arch/arm/kernel/thread.c and normalworld in optee_client/tee_supplicant driver
more on this in the [official doc](https://optee.readthedocs.io/architecture/core.html?highlight=rpcs).

* Test application: run `tests` in NW terminal

Directory **random/**:
* Generates a random UUID using capabilities of TEE API (`TEE_GenerateRandom()`).
* Test application: `optee_example_random`

Directory **aes/**:
* Runs an AES encryption and decryption from a TA using the GPD TEE Internal
Core API. Non secure test application provides the key, initial vector and
ciphered data.
* Test application: `optee_example_aes`

