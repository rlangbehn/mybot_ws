# Commands & scratch pad

## General commands

Shape console (defaults etc)

```bash
IMAGE_NAME="rossws"
CONTAINER_NAME="${IMAGE_NAME}_run"
HOSTNAME="ros_full"
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
