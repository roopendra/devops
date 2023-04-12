# Docker 

![image](https://user-images.githubusercontent.com/1461161/231353641-620b1e65-a533-4c87-a27b-ae9020ea972e.png)
![image](https://user-images.githubusercontent.com/1461161/231353737-80d8c2bd-c3f5-4426-93d0-092cb69fbc81.png)
![image](https://user-images.githubusercontent.com/1461161/231353756-291f5b9e-c3a7-4a46-909f-99f52be7a944.png)
![image](https://user-images.githubusercontent.com/1461161/231353789-b9aa4f1c-69b9-4fb5-890c-d0fdaea48c5c.png)
![image](https://user-images.githubusercontent.com/1461161/231353839-6b04decc-7173-4367-b543-01a1e9a7b2d6.png)
![image](https://user-images.githubusercontent.com/1461161/231353882-ee0fbbbd-c3e0-4c7d-8e8c-55b92e795584.png)
![image](https://user-images.githubusercontent.com/1461161/231353902-6019bddb-785b-4277-960d-08525cb1c2e1.png)
![image](https://user-images.githubusercontent.com/1461161/231353997-1f17e2b8-a25d-41bf-85e3-36436405fe78.png)


## Docker Command Reference
`docker ps` 		: 	list running containers.   
`docker ps -a` 	: 	list all container including stopped container  
`docker pull` 	:	download a image from Docker Hub registry. Link to the docker image is always shown on the right at dockerhub.  
`docker build` 	: 	is used to build your own container based on a Dockerfile. Common use is docker build . to build a container based on the Dockerfile in the current directory (the dot). docker build -t "myimage:latest" . creates a container and stores the image under the given name

`docker images or docker image ls` : shows all local storage images

`docker run`	:	Run a docker container based on an image, i. e. docker run myimage -it bash. If no local image can be found docker run automatically tries to download the image from Docker hub.   
`docker logs`:  display the logs of a container, you specified. To continue showing log updates just use `docker logs -f mycontainer`    
`docker volume ls` lists the volumes, which are commonly used for persisting data of Docker containers.  
`docker network ls` list all networks available for docker container    
`docker network` connect adds the container to the given container network. That enables container communication by simple container name instead of IP.    
`docker rm` ---removes one or more containers. docker rm mycontainer, but make sure the container is not running    
`docker rmi`  removes one or more images. docker rmi myimage, but make sure no running container is based on that image  
`docker stop` --- stops one or more containers. docker stop mycontainer stops one container, while `docker stop $(docker ps -a -q)` stops all running containers.   
`docker start` – starts a stopped container using the last state  
`docker update –restart=no` : updates container policies, that is especially helpful when your container is stuck in a crash loop  
`docker cp` :	to copy files from a running container to the host or the way around. docker cp :/etc/file . to copy /etc/file to your current directory.  

## Some combinations that help a lot:

**kill all running containers with**  
	```
	docker kill $(docker ps -q)
	```  
**delete all stopped containers with**  
	```
	docker rm $(docker ps -a -q)
	```  
**delete all images with**  
	```
	docker rmi $(docker images -q)
	```  
**update and stop a container that is in a crash-loop with**  
	```docker update –restart=no && docker stop```   
**bash shell into container**  
	```docker exec -i -t /bin/bash``` – if bash is not available use /bin/sh  
**bash shell with root if container is running in a different user context**  
	```docker exec -i -t -u root /bin/bash```   

## Docker Compose Installation on Ubuntu
```
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

if you have cloned this repository then go devops/docker/docker_comp1 directory and run below command
```
docker-compose up -d
```
