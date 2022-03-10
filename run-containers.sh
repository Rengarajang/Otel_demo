#!/bin/bash
echo "Building Docker images.."
mvn clean package docker:build
echo "Created Docker images.."
docker images
echo "Changing Permission for the mount folder.."
chmod -R 777 data
sysctl -w vm.max_map_count=262144 
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
echo "Starting all containers.."
docker-compose up -d
echo "------------------Started containers---------"
docker ps
echo "-------------------------------------"
