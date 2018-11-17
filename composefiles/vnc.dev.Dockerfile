# https://hub.docker.com/r/misterkoz/ros-melodic-with-vnc-and-gazebo/
FROM misterkoz/ros-melodic-with-vnc-and-gazebo

## apt-install all your ros packages here

# Copy files across
RUN rosdep init
RUN rosdep fix-permissions

# Profile Stuff
USER ubuntu
COPY composefiles/bash_profile /home/ubuntu/.bashrc
COPY composefiles/vimrc /home/ubuntu/.vimrc

# Root user
USER root
