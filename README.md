# Melodic mybot_ws on docker

Forked from : [richardw05/mybot_ws](https://github.com/richardw05/mybot_ws)

## The Goal

To make this great example of a simple but complete ROS/Gazebo implementation work with ROS Melodic and run on docker on mac, linux and probably windows

## Requirements

* Docker (created with docker 18)
* homebrew
* gazebo [Homebrew guide here](http://gazebosim.org/tutorials?tut=install_on_mac)

## Hitting the ground and running

Todo

## Todo

Using [this](http://moorerobots.com/blog/post/1) as a base

1. ~~migrate mybot_ws to melodic~~
1. ~~make it run in docker (single container)~~
1. ~~connect video into docker: [from here](https://wiki.ros.org/docker/Tutorials/GUI) & [maybe a docker file here](https://hub.docker.com/r/ct2034/vnc-ros-kinetic-full/~/dockerfile/)~~
1. ~~make gazebo work in a container~~
1. ~~make gazebo work with remote video~~
1. make it interract with gazebo on mac (host-only network ?)
1. make it all automatable
1. customise the crap outa it for specific robot stuff
1. update the docs to be able to run all of the origonal tutorials

## Licence

This is a fork of someone else's work, there is no license except that by using this repo, you agree that the contributors are not at all to blame for any outcomes; good, bad, or otherwise that you may create through the use of this repo. 

Especially if you create an army of sentient machines that takes over the world - totally not responsible for that.

## links

* [the video that sparked interest](http://moorerobots.com/blog/post/1)
* [the repo this is forked from](https://github.com/richardw05/mybot_ws)
* [ROS source images from osrf](https://github.com/osrf/docker_images/tree/master/ros/melodic/ubuntu/bionic)
* [A dockerfile that's got some insipirational bits](https://github.com/ChrisTimperley/TurtleBot.Dockerfile/blob/master/source/Dockerfile)
* [Another docker file](https://hub.docker.com/r/ct2034/vnc-ros-kinetic-full/~/dockerfile/)
* [A docker file with VNC in it](https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/)

## Credits

Credit goes to:

* the original repo creator [richardw05/mybot_ws](https://github.com/richardw05/mybot_ws)
* the docker people
* the ROS people
* the gazebo people
* my mum
* your mum
* lol
