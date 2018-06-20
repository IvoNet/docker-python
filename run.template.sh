#!/bin/sh
NAME=CONTAINER

echo "Enabling DISPLAY for python..."
export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
open -a XQuartz
xhost + $IP

if [ "$1" == "." ]; then
    if [ "$(docker ps -aq -f status=exited -f name=${NAME})" ]; then
        echo "Resetting state..."
        docker rm ${NAME} >/dev/null
    fi
fi

if [ "$(docker ps -q -f name=${NAME})" ]; then
        echo "Attaching to running container..."
        docker attach ${NAME}
else
    if [ "$(docker ps -aq -f status=exited -f name=${NAME})" ]; then
        echo "Start existing container..."
        docker start -i ${NAME}
    else
        echo "Init CONTAINER container..."
        docker run -it --name ${NAME} -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$(pwd):/project" -p 3000:3000 -p 8888:8888 ivonet/${NAME}
    fi
fi