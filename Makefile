# Common vars 
IMAGE_NAME=misterkoz/ros-melodic-with-vnc-and-gazebo
CONTAINER_NAME=ros-melodic-with-vnc-and-gazebo/run

##A make file with docs!
##--------------------------------------------------------
help:              ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build:             ## Build the image
	docker build -t ${IMAGE_NAME} .

push:              ## Push the image
	docker login
	docker push ${IMAGE_NAME}

compose-build:
	docker-compose build

##up:                 Run the vnc containers
up: compose-build
	docker-compose up
##