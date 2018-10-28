# Common vars
VNC_PARENT_IMAGE_NAME=misterkoz/ros-melodic-with-vnc-and-gazebo
VNC_PARENT_CONTAINER_NAME=ros-melodic-with-vnc-and-gazebo/run

VNC_IMAGE_NAME=misterkoz/ros-with-vnc-mybot-ws
VNC_CONTAINER_NAME=ros-with-vnc-mybot-ws_run

DESKTOP_IMAGE_NAME=misterkoz/ros_desktop
DESKTOP_CONTAINER_NAME=ros_desktop_run

##
##General Targets
##--------------------------------------------------------
help:                      ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

##build-all:                  Builds all containers
build-all: update desktop-build vnc-parent-build vnc-build

update:                    ## Updates the local code
	# git1
	git pull
	# version file updates
##
##VNC parent image
##--------------------------------------------------------
vnc-parent-build:          ## Build the vnc parent image
	docker build -t ${VNC_PARENT_IMAGE_NAME} -f vnc.parent.Dockerfile .

vnc-parent-push:           ## Pushes the vnc parent image
	docker login
	docker push ${VNC_PARENT_IMAGE_NAME}

vnc-parent-run:            ## Runs the vnc parent as a container
	docker run -p 2222:22 -p 6080:80 -p 5900:5900 --rm --name ${VNC_PARENT_CONTAINER_NAME} ${VNC_PARENT_IMAGE_NAME}

##vnc-parent-build-run:       Builds and then runs the VNC parent container
vnc-parent-build-run: vnc-parent-build vnc-parent-run

##
##Full VNC Container
##--------------------------------------------------------
vnc-build:                 ## Builds the child VNC container
	docker build -t ${VNC_IMAGE_NAME} -f vnc.Dockerfile .

vnc-run:                   ## Runs the vnc containers
	docker run -p 2222:22 -p 6080:80 -p 5900:5900 --rm --name ${VNC_CONTAINER_NAME} ${VNC_IMAGE_NAME}

##vnc-build-run:              Builds and then runs the VNC container
vnc-build-run: vnc-build vnc-run

##
##ROS Desktop images
##--------------------------------------------------------
desktop-build:             ## Build Desktop
	docker build -t ${DESKTOP_IMAGE_NAME} -f desktop.Dockerfile .

##desktop-run:                Run the Desktop
desktop-run: build-desktop
	docker run -p 2222:22 -p 5900:5900 --rm --name ${DESKTOP_CONTAINER_NAME} ${DESKTOP_IMAGE_NAME}

##desktop-build-run:          Build and run the desktop
desktop-build-run: desktop-build desktop-run
##
