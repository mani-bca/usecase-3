#!/bin/bash
apt-get update -y
apt-get install -y docker.io
 
systemctl enable docker
systemctl start docker
 
docker run -d \
  --name openproject \
  -p 8080:80 \
  openproject/openproject:15.4.2-sli
 