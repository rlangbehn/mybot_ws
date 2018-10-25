# https://hub.docker.com/r/misterkoz/ros-melodic-with-vnc-and-gazebo/
FROM misterkoz/ros-melodic-with-vnc-and-gazebo

## apt-install all your ros packages here

# Copy files across
ARG WORKSPACE=/home/ubuntu/catkin_ws
ENV WORKSPACE=${WORKSPACE}

COPY project_root ${WORKSPACE}
RUN chown -R ${USERNAME}:${USERNAME} ${WORKSPACE}

RUN rosdep init
RUN rosdep fix-permissions

# Assume Ubuntu user - we don't want ROS running as root!
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


# the startup script needs to run as root
USER root

ENV VNC_PASSWORD=ubuntu
ENV PASSWORD=${VNC_PASSWORD}
ENV RESOLUTION=1920x1080