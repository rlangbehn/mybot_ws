# https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/
FROM dorowu/ubuntu-desktop-lxde-vnc

ENV VNC_PASSWORD=ubuntu
ENV RESOLUTION=1920x1080

## -------- Pulled from  https://github.com/osrf/docker_images/blob/master/ros/melodic/ubuntu/bionic/ros-core/Dockerfile

# install packages
RUN apt-get update && \
    apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# -------- install ros packages
ENV ROS_DISTRO melodic
RUN apt-get install -y \
    ros-melodic-desktop-full=1.4.1-0* \
    ros-melodic-ros-control \
    ros-melodic-ros-controllers \
    ros-melodic-gazebo-msgs \
    ros-melodic-gazebo-ros \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# -------- My Stuff

# Define variables
ARG USERNAME=ubuntu
ARG WORKDIR=/home/ubuntu
ARG WORKSPACE=/home/ubuntu/catkin_ws

# Variables as ENV vars
ENV USERNAME=${USERNAME}
ENV WORKDIR=${WORKDIR}
ENV WORKSPACE=${WORKSPACE}


# Tooling - network
# RUN apt-get install iputils-ping -y

# Create user
RUN useradd -ms /bin/bash $USERNAME
RUN chpasswd ${USERNAME} ${VNC_PASSWORD}

# Working dir
WORKDIR ${WORKDIR}

# Copy files across
COPY project_root ${WORKSPACE}

# Init ros project space
RUN chown -R ${USERNAME}:${USERNAME} /home/ubuntu

# Some ROS things
USER ${USERNAME}

RUN echo "export ROS_HOSTNAME=localhost" >> ~/.bashrc
RUN echo "export ROS_MASTER_URI=http://localhost:11311" >> ~/.bashrc

RUN echo "source /opt/ros/melodic/setup.bash"  >> ~/.bashrc
RUN echo "source ${WORKSPACE}/devel/setup.bash" >> ~/.bashrc

RUN bash -c "source /opt/ros/melodic/setup.bash && \
             cd ${WORKSPACE}/src && \
             catkin_init_workspace && \
             cd .. && \
             catkin_make && \
             rosdep update"
          
USER root
