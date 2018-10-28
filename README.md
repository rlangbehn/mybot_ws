# Melodic mybot_ws on docker

Forked from : [richardw05/mybot_ws](https://github.com/richardw05/mybot_ws)

## WTF? (What's this for?)

I wanted to build a ROS powered robot called Speedy and I needed a stable development environment that would work on my mac (and possibly windows) and I needed a walkthrough. My ultimate goal is to simulate a complete robot and use a complete virutal environment to implement machine learning for improvements.

I couldn't find much by way of a walkthrough but I did find [this excellent tutorial](http://moorerobots.com/blog/post/1) but it was a little out of date and also wasn't going to work on OSX. This should work on OSX and Linux.

I created a docker environment that a person could feasbily use to run through the tutorials including a complete all-in-one docker container that is used as a parent.

## Requirements

* Docker (created with docker 18)
* Bash
* patience

## Howto

This repo contains all the the code to run the tutorials on the [tutorials here](http://moorerobots.com/blog/post/1) in docker, on the mac, thats what it does.

### To run the container

* In your console type `make vnc-run` and wait for the build to finish
* Open a browser to [http://localhost:6080](http://localhost:6080)
* login as `ubuntu:ununtu` in vnc
* open up a terminal `menu/System Tools/LXTermal` run `roslaunch mybot_gazebo mybot_world.launch` (tab completion works)
* wait for gazebo to load
* open up another terminal and execute the `turn.sh` file in the `catkin_ws` folder
* follow the tutorials to learn more

### To run the container with your own project folder

The makefile is just there to simplify the commands to run the docker container, tweak it to your needs.

To mount in your own code, change the line in the makefile from:

```bash
docker run -p 2222:22 -p 6080:80 -p 5900:5900 --rm --name ${VNC_PARENT_CONTAINER_NAME} ${VNC_PARENT_IMAGE_NAME}
```

To something that contains a volume mount:

```bash
docker run -p -v my_cool_local_folder:/home/ubuntu/my_cool_target_folder 2222:22 -p 6080:80 -p 5900:5900 --rm --name ${VNC_PARENT_CONTAINER_NAME} ${VNC_PARENT_IMAGE_NAME}
```

## More detail

Everything is in the Makefile. To get a detailed list type `make` or `make help` and it will say what each make target does.

The repo contains all of the work to date of building the 

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
