#!/bin/bash

# run dockerized cewe-fotowelt
xhost +local:docker 
docker run -it \
    --rm \
    --user "$(id -u):$(id -g)" \
    --mount type=bind,source=$(cd && pwd),target=/home/ubuntu \
    --network host \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --ipc=host \
    --name cewe-fotowelt \
    --privileged \
    cewe:latest

    #--mount type=bind,source=$(pwd)/${WORK_DIR},target=/data \
    #--entrypoint="bash" \
