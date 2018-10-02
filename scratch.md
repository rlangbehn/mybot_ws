# Commands & scratch pad

## General commands

Shape console (defaults etc)

`CONTAINER_NAME=rossws`

run roscontainer from osrf (full desktop!?)

`docker run --rm -it osrf/ros:melodic-desktop-full`

run this ros container with interactive shell

`docker run --rm -it  --hostname ros_full --network host --name rossws_run rossws`

run this ros container as a daemon

`docker run --rm -d --network host --name rossws_run rossws`

Build from dockerfile

`docker build -t ${CONTAINER_NAME} .`
