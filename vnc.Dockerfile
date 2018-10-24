# https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/
FROM dorowu/ubuntu-desktop-lxde-vnc

# install base packages
RUN apt-get update && \
    apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release \
    build-essential \
    gcc \
    g++ \
    ssh \
    tmux \
    screen

# Getting supervisorD to look after ssh
RUN echo "[program:sshd]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/supervisord.conf

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list for ROS
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

# setup environment vars
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV ROS_DISTRO=melodic

# install ros packages
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    ros-melodic-desktop-full=1.4.1-0* \
    ros-melodic-ros-control \
    ros-melodic-ros-controllers \
    ros-melodic-gazebo-msgs \
    ros-melodic-gazebo-ros 

# bootstrap rosdep
RUN rosdep init

# Define variables
ARG USERNAME=ubuntu
ARG WORKDIR=/home/ubuntu
ARG WORKSPACE=/home/ubuntu/catkin_ws
ENV USERNAME=${USERNAME}
ENV WORKDIR=${WORKDIR}
ENV WORKSPACE=${WORKSPACE}

# Forces this user :D
ENV USER=${USERNAME}

# Create user
RUN useradd -ms /bin/bash $USERNAME
RUN usermod -aG sudo ${USERNAME}

# Working dir
WORKDIR ${WORKDIR}

# Copy files across
COPY project_root ${WORKSPACE}

# Init ros project space
RUN chown -R ${USERNAME}:${USERNAME} /home/ubuntu

# Some ROS things
USER ${USERNAME}

# bootstrap rosdep
RUN rosdep update

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

ENV VNC_PASSWORD=ubuntu
ENV PASSWORD=${VNC_PASSWORD}
ENV RESOLUTION=1920x1080

USER root
