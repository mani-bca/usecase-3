#!/bin/bash
apt-get update -y
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
sudo docker network create devlake-network

sudo docker run -d --name devlake-mysql \
  --network devlake-network \
  -e MYSQL_ROOT_PASSWORD=admin \
  -e MYSQL_DATABASE=lake \
  -e MYSQL_USER=merico \
  -e MYSQL_PASSWORD=merico \
  -p 3306:3306 \
  mysql:8

sudo docker run -d --name devlake --network devlake-network -e "DB_URL=mysql://merico:merico@devlake-mysql:3306/lake?charset=utf8mb4&parseTime=True" -e "ENCRYPTION_SECRET=merico1234abcd" -p 8080:8080 apache/devlake:latest

sudo docker run -d --name config-ui --network devlake-network -e DEVLAKE_ENDPOINT=http://devlake:8080 -p 4000:4000 apache/devlake-config-ui:latest

sudo docker run -d --name grafana --network devlake-network -e GF_SECURITY_ADMIN_USER=admin -e GF_SECURITY_ADMIN_PASSWORD=admin -p 3000:3000 apache/devlake-dashboard:latest