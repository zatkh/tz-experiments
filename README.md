# basic tz tests
Build:

1- build script:

>> ./build.sh 

or

2- Docker:   

>> sudo docker build -t test .  

>> docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix test  

>> cd /test-tz/build  

>> make ta-targets=ta_arm64 run -j$(nproc)

