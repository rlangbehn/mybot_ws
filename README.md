# Melodic mybot_ws on docker

Forked from : [richardw05/mybot_ws](https://github.com/richardw05/mybot_ws)

## WTF? (What's this for?)

I wanted to build a ROS powered robot and I needed a stable development environment that would work on my mac or Windows/WSL and I needed a walkthrough. My ultimate goal is to simulate a complete robot and use a complete virutal environment to implement machine learning for improvements.

I couldn't find much by way of a walkthrough but I did find [this excellent tutorial](http://moorerobots.com/blog/post/1) but it was a little out of date and also wasn't going to work on OSX. This should work on OSX and Linux.

I created a docker environment that a person could feasbily use to run through the tutorials including a complete all-in-one docker container that is used as a parent.

## Requirements

* Docker
* Bash

## Howto

### To run the container

* In your console type `make up` and wait for the build to finish
* Open a browser to [http://localhost:6080](http://localhost:6080)
* login as `ubuntu:ununtu` in the http vnc client
* or ssh to the container on port 222 with `ssh -v -p 2222 ubuntu@localhost`

### To run the tutorials

* Run the container with `make up`
* Login as `ubuntu:ununtu` in the http vnc client
* Open up a terminal `menu/System Tools/LXTermal` run `roslaunch mybot_gazebo mybot_world.launch` (tab completion works)
* Wait for gazebo to load
* Open up another terminal and execute the `turn.sh` file in the `catkin_ws` folder
* Follow the tutorials to learn more

## To run the container with your own project folder

Replace the `project_root` directory with your own.

## More detail

Everything is in the Makefile. To get a detailed list type `make` or `make help` and it will say what each make target does.

The makefile is just there to simplify the commands to run the docker container, tweak it to your needs.

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
