#!/bin/bash

# Update system packages
echo "Updating system packages..."
apt-get update -y
apt-get upgrade -y

# Install required dependencies
echo "Installing dependencies..."
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Install Docker
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
echo "Installing Docker Compose..."
curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Start Docker service
echo "Starting Docker service..."
systemctl start docker
systemctl enable docker

# Create directory for DevLake
echo "Setting up DevLake..."
mkdir -p /opt/devlake
cd /opt/devlake

# Download DevLake docker-compose file
curl -LO https://raw.githubusercontent.com/apache/incubator-devlake/main/docker-compose.yml

# Modify the configuration to expose port 8080
sed -i 's/8080:8080/8080:8080/g' docker-compose.yml

# Start DevLake
echo "Starting DevLake services..."
docker-compose up -d

echo "Installation complete. DevLake should be available on port 8080."