#!/bin/sh

# Check if the --mirror flag is present
if [[ "$1" == "--mirror" ]]; then
  # Use domestic mirror for China users
  DOCKER_COMPOSE_URL="https://ghgo.xyz/https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-linux-x86_64"
else
  # Use official Docker Compose URL
  DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-linux-x86_64"
fi

# Install curl
sudo apt install curl -y

# Download and install Docker
curl -fsSL get.docker.com -o- get-docker.sh | bash

# Download and install Docker Compose
curl -L "$DOCKER_COMPOSE_URL" >/usr/local/bin/docker-compose

# Make Docker Compose executable
sudo chmod +x /usr/local/bin/docker-compose

# Source zshrc (if using zsh)
if [[ "$(uname -s)" == "ZSH" ]]; then
  source ~/.zshrc
fi
