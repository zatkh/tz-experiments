# basic tz tests
Build:

1- build script:

>> ./build.sh 

or

2- Docker:   

>> sudo docker build -t test .  

>> xhost + (warning: allowing to open up any X11 window on you machine)  

>> docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix test  

>> cd home/test-tz/build  

>> make ta-targets=ta_arm64 run -j$(nproc)

Tests: 

In NW terminal after login (type root), run minor_test(or other tests in examples directory)

