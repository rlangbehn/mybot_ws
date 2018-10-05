# Docs

Software simulation in ROS can help you learn about how to make robots **"think"**. After all, it is a big leap to go from line following robots to self-driving cars. Arguably, one of the biggest challenges in building useful robots is the software. Through ROS, you will be able to understand how the fundamental challenges of using sensors to determine where the robot is **(sensing)**, developing plans to figure out what the robot should do **(planning)**, and then computing commands for the robot to execute **(acting)**.

In this tutorial, we will develop a simulated robot from scratch (well...relative to the turtlebot simulation). There are several reasons why you may wish to go this route.

1. Simulate your own custom built robot by editing the URDF model (so you aren't stuck with the turtlebot)
2. Enable development of algorithms that can be [plugged into both software and hardware robots](http://gazebosim.org/tutorials/?tut=ros_control) (because excessive development on hardware is susceptible to wear and tear)
3. Exposure to ROS robot architecture (so you can avoid repeating design mistakes others already learned from)

## Overview: Simulated Model

### Goal

Create a URDF model in the Gazebo simulator that is accessible by ROS.

**References**: There are a number of helpful tutorials. None of them worked flawlessly for me out of the box. I suspect that they are not up-to-date but it is also possible that I failed to properly follow the instructions:

* [RRBot](http://gazebosim.org/tutorials/?tut=ros_urdf)
* [R2D2](http://wiki.ros.org/urdf/Tutorials/Building%20a%20Visual%20Robot%20Model%20with%20URDF%20from%20Scratch)
* [Differential Drive](http://www.generationrobots.com/blog/en/2015/02/robotic-simulation-scenarios-with-gazebo-and-ros/) (URDF format)
* [Differential Drive](http://www.theconstructsim.com/how-to-build-a-differential-drive-simulation/) (SDF format)

**Result**: A simple differential drive model built from scratch that is simulated in Gazebo and visualizable in rviz

**Repository Code**

git clone -b base https://github.com/richardw05/mybot_ws.git

**Video Walkthrough**

### Compatability

This tutorial will no doubt become dated over time. This is the hardware and software used for this writeup:

Software

* **ROS**: Kinetic
* **OS**: Ubuntu 16.04
* **OS**: Gazebo 7.0.0

Hardware

* **RAM**: 8GB DDR4
* **SSD**: Samsung EVO
* **CPU**: Intel i5
* **GPU**: GTX 750ti

### Directory Structure

Brief explanation:

1. **mybot_description** specifies the entire robot structure as links and joints and can launch the model in rviz.
2. **mybot_gazebo** launches the model in the gazebo environment and contains different simulation worlds.
3. **mybot_control** (not used) enable control over joints of our model so that it can move around.

To learn more about creating a workspace/package, check out this [tutorial on YouTube.](https://www.youtube.com/watch?v=9U6GDonGFHw)

To create the basic skeleton of the directory structure, we begin with a workspace _{WORKSPACE}_ws_, where we set _{WORKSPACE}_\=mybot.

```bash
cd ~
mkdir mybot_ws
cd mybot_ws
catkin init
mkdir src
catkin build
echo "source ~/mybot_ws/devel/setup.bash" >> ~/.bashrc # Adds workspace to search path
```

In the src folder are three main packages, _{MODEL}_control_, _{MODEL}_description_, _{MODEL}_gazebo_. We set _{MODEL}_ = mybot. To create a package: catkin_create_pkg _{PKG_NAME}_ _{PKG_DEPENDENCIES}_. In this case, we have no _{PKG_DEPENDENCIES}_ = "".

```bash
cd ~/mybot_ws/src/
catkin_create_pkg mybot_control
catkin_create_pkg mybot_description
catkin_create_pkg mybot_gazebo
```

### Create the Robot Model (URDF)

In ~/mybot_ws/src/mybot_description/urdf, there are four files:

* mybot.xacro: primary file that loads the other three files and contains only URDF items like joints and links
* mybot.gazebo: contains gazebo-specific labels that are wrapped within gaz
* materials.xacro: maps strings to colors
* macros.xacro: macros to help simplify

### Run the Models

Load the Gazebo simulator and rviz in separate terminals

```bash
roslaunch mybot_gazebo mybot_world.launch
roslaunch mybot_description mybot_rviz.launch
```

Send a base controller command and ensure that the robot moves in both Gazebo and rviz

```bash
rostopic pub cmd_vel geometry_msgs/Twist "linear:
  x: 0.2
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 0.1"
```

### Misc

If the Gazebo plugin cannot be found, install the ros kinetic controllers

```bash
  sudo apt-get install ros-kinetic-ros-control
  sudo apt-get install ros-kinetic-ros-controllers
  sudo apt-get install ros-kinetic-gazebo-msgs
  sudo apt-get install ros-kinetic-gazebo-ros
```

If robot is not moving in rviz, check the tf transformation tree

```bash
  rosrun tf view_frames
  evince frames.pdf
```

If you want to run your own controller in mybot_controller, check out this [tutorial](http://www.generationrobots.com/blog/en/2015/02/robotic-simulation-scenarios-with-gazebo-and-ros/)