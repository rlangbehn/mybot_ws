# Commands & scratch pad

## General commands

Shape console (defaults etc)

```bash
IMAGE_NAME="rossws"
CONTAINER_NAME="${IMAGE_NAME}_run"
HOSTNAME="ros_full"
```

run ros container from dorowu/ubuntu-desktop-lxde-vnc

```bash
docker run --rm -it dorowu/ubuntu-desktop-lxde-vnc
```

Build and run the VNC ROS master thing :)

```bash
VNC_IMAGE_NAME="rossws_vnc"
VNC_CONTAINER_NAME="${VNC_IMAGE_NAME}_run"
docker build -t ${VNC_CONTAINER_NAME} -f vnc.Dockerfile .
docker run -p 2222:22 -p 6080:80 -p 5900:5900 --rm --name ${VNC_IMAGE_NAME} ${VNC_CONTAINER_NAME}
```

run roscontainer from osrf (full desktop!?)

```bash
docker run --rm -it osrf/ros:melodic-desktop-full
```

run this ros container with interactive shell

```bash
docker run --rm -it --hostname ${HOSTNAME} --network host --name ${CONTAINER_NAME} ${IMAGE_NAME}
```

run this ros container as a daemon

```bash
docker run --rm -d --hostname ${HOSTNAME} --network host --name ${CONTAINER_NAME} ${IMAGE_NAME}
```

Build from dockerfile

```bash
docker build -t ${IMAGE_NAME} .
```
