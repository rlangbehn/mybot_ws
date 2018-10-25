VNC_PARENT_IMAGE_NAME=misterkoz/ros-melodic-with-vnc-and-gazebo
VNC_IMAGE_NAME="rossws_vnc"
VNC_CONTAINER_NAME?="${VNC_IMAGE_NAME}_run"

DESKTOP_IMAGE_NAME=rossws_desktop
DESKTOP_CONTAINER_NAME=${DESKTOP_IMAGE_NAME}_run

update: ## Updates the local code
	git pull

build-vnc: update ## Builds the child VNC container
	docker build -t ${VNC_CONTAINER_NAME} -f vnc.Dockerfile .

build-vnc-parent: update 
	docker build -t ${VNC_PARENT_IMAGE_NAME} -f vnc.parent.Dockerfile .

push-vnc-parent: build-vnc-parent
	docker login
	docker push ${VNC_PARENT_IMAGE_NAME}

build-desktop:
	docker build -t ${DESKTOP_IMAGE_NAME} -f desktop.Dockerfile .

run-desktop:
	docker run -p 2222:22 -p 5900:5900 --rm --name ${DESKTOP_CONTAINER_NAME} ${DESKTOP_IMAGE_NAME}