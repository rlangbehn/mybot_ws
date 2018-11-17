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
* login as `ubuntu:ununtu` in the http vnc client
* or ssh to the container on port 222 with `ssh -v -p 2222 ubuntu@localhost`

### To run the tutorials

* Run the container
* Login as `ubuntu:ununtu` in the http vnc client
* Open up a terminal `menu/System Tools/LXTermal` run `roslaunch mybot_gazebo mybot_world.launch` (tab completion works)
* Wait for gazebo to load
* Open up another terminal and execute the `turn.sh` file in the `catkin_ws` folder
* Follow the tutorials to learn more

## To run the container with your own project folder

To mount in your own code, you should run this with a docker-compose setup.

The docker-compose file opens up all the correct ports and maps the project_root folder into the container's folder. It makes use of the `vimrc` and `bash_profile` files to make things a bit tidier. Using this method, the project isn't build from the start so I've added in a build script, the build script also calls in the `/home/ubuntu/catkin_ws/devel/setup.bash` file so ROS commands have tab completion.

### Steps

1. Copy these files into your code repo:
    * `docker-compose.yml`
    * `composefiles/vnc.dev.Dockerfile`
    * `composefiles/vimrc`
    * `composefiles/bash_profile`
2. Put your code files into a sub folder called `project_root` or create your own folder and update the `docker-compose.yml` file folder reference
3. Build the compose container with `# docker-compose build`
4. Run the compose container with `# docker-compose up`
5. ssh into the container `ssh -v -p 2222 ubuntu@localhost` password is set in the compose file - defaults to `ubuntu`
6. Cd into the `catkin_ws` folder and run the build `# cd catkin_ws/ && ./build.sh`

You can copy a handful of files into your own code repo to make this work without all the extra bits.

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
