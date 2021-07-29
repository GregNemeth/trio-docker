#!/bin/bash
export MYSQL_ROOT_PASSWORD=password MYSQL_DATABASE=flask-db

docker network create trio-task-network

docker build -t trio-task-app flask-app
docker run -d --name trio-task-app --network trio-task-network trio-task-app

docker build -t trio-task-db db
docker run -d --name trio-task-db --network trio-task-network trio-task-db

docker run -d -p 80:80 --network trio-task-network --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf --name trio-task-proxy nginx:alpine
