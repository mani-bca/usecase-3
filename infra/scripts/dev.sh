#!/bin/bash

# Script to install Docker and Docker Compose, download DevLake's
# docker-compose.yml, and start DevLake on the default port 4000.

echo "Starting the setup of DevLake on your Ubuntu EC2 instance..."

# Step 1: Update package lists
echo "Updating package lists..."
sudo apt update -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to update package lists. Please check your internet connection and try again."
  exit 1
fi

# Step 2: Install Docker
echo "Installing Docker..."
sudo apt install docker.io -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to install Docker. Please check the output for errors."
  exit 1
fi

# Step 3: Start and enable Docker service
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker
if [ $? -ne 0 ]; then
  echo "Error: Failed to start or enable Docker service."
  exit 1
fi

# Step 4: Install Docker Compose
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION="v2.20.2" # You can check for the latest version on Docker's GitHub
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
if [ $? -ne 0 ]; then
  echo "Error: Failed to download Docker Compose."
  exit 1
fi
sudo chmod +x /usr/local/bin/docker-compose
if [ $? -ne 0 ]; then
  echo "Error: Failed to make Docker Compose executable."
  exit 1
fi

# Verify Docker Compose installation (optional)
echo "Verifying Docker Compose installation..."
docker-compose --version

# Step 5: Download the DevLake Docker Compose file
echo "Downloading the DevLake docker-compose.yml file..."
wget https://raw.githubusercontent.com/apache/incubator-devlake/main/docker-compose.yml
if [ $? -ne 0 ]; then
  echo "Error: Failed to download the DevLake docker-compose.yml file."
  exit 1
fi

# Step 6: Start DevLake using Docker Compose
echo "Starting DevLake using Docker Compose..."
docker-compose up -d
if [ $? -ne 0 ]; then
  echo "Error: Failed to start DevLake using Docker Compose. Check the output for errors."
  echo "You can try to see the logs with: docker-compose logs"
  exit 1
fi

echo "DevLake should now be running on your EC2 instance on port 4000."
echo "You can access it in your browser using: http://your_ec2_public_ip:4000"
echo "Remember to ensure your EC2 security group allows inbound traffic on TCP port 4000."

exit 0