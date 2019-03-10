# basic tz tests

###Main Components:

optee_os: secure world kernel

arm trusted firmware: secure boot

linux: normal world OS

optee_client: mormal world driver

optee_examples: simple aplication examples

###Build:

1- build script:

>> ./build.sh 

or

2- Docker:   

>> sudo docker build -t test .  

>> xhost + (warning: allowing to open up any X11 window on you machine)  

>> docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix test  

>> cd home/test-tz/build  

>> make ta-targets=ta_arm64 run -j$(nproc)

3- Boot kernel with ARM trusted firmware only (no optee):

>> ./run-ATF-only (after ./build.sh)

###Run Tests: 

In NW terminal after login (type root), run tests(or other examples in optee_examples directory)

