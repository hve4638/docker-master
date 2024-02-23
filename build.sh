#!/bin/bash
IMAGE_NAME=hve/dockermaster

if [ ! -z "$(docker images | grep $IMAGE_NAME)" ]; then
    docker image rm $IMAGE_NAME
    if [ $? -ne 0 ]; then
        echo "Fail to build '$IMAGE_NAME'"
        exit 1
    fi
fi

docker build -t $IMAGE_NAME .
if [ $? -eq 0 ]; then
    echo "Success to build '$IMAGE_NAME'"
    exit 0
else
    echo "Fail to build '$IMAGE_NAME'"
    exit 1
fi
