# all in one dockerfile
FROM osrf/ros:melodic-desktop-full

# Define variables
ARG USERNAME=rosuser
ARG WORKDIR=/home/rosuser
ARG WORKSPACE=/home/rosuser/catkin_ws

# Variables as ENV vars
ENV USERNAME=${USERNAME}
ENV WORKDIR=${WORKDIR}
ENV WORKSPACE=${WORKSPACE}

RUN apt-get update
RUN apt-get install ros-melodic-ros-control ros-melodic-ros-controllers ros-melodic-gazebo-msgs ros-melodic-gazebo-ros -y

# Tooling - network
RUN apt-get install iputils-ping -y

# Create user
RUN useradd -ms /bin/bash $USERNAME

# Working dir
WORKDIR ${WORKDIR}

# Copy files across
COPY project_root ${WORKSPACE}

# Init ros project space
RUN chown -R ${USERNAME}:${USERNAME} /home/rosuser

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
