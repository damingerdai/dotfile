#!/bin/bash

# Define Docker Compose version
DOCKER_COMPOSE_VERSION="v2.32.1"

# Check if the --mirror flag is present
if [[ "$1" == "--mirror" ]]; then
  # Use domestic mirror for China users
  DOCKER_COMPOSE_URL="https://ghgo.xyz/https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-linux-x86_64"
else
  # Use official Docker Compose URL
  DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-linux-x86_64"
fi

# Install curl if not already installed
if ! command -v curl >/dev/null 2>&1; then
  echo "Installing curl..."
  sudo apt update
  sudo apt install curl -y
else
  echo "curl is already installed."
fi

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com | bash || {
  echo "Failed to install Docker. Exiting."
  exit 1
}

# Ensure the target directory exists
CLI_PLUGINS_DIR="$HOME/.docker/cli-plugins"
mkdir -p "$CLI_PLUGINS_DIR"

# Download and install Docker Compose
echo "Downloading Docker Compose $DOCKER_COMPOSE_VERSION..."
if curl -L "$DOCKER_COMPOSE_URL" -o "$CLI_PLUGINS_DIR/docker-compose"; then
  echo "Setting Docker Compose as executable..."
  chmod +x "$CLI_PLUGINS_DIR/docker-compose"
else
  echo "Failed to download Docker Compose. Please check your internet connection and URL."
  exit 1
fi

# Verify Docker Compose installation
if docker compose version >/dev/null 2>&1; then
  echo "Docker Compose $(docker compose version) installed successfully."
else
  echo "Docker Compose installation failed."
  exit 1
fi

echo "Start running docker engine."
sudo systemctl enable docker
sudo systemctl start docker

echo "Add current user into docker user groups."
sudo groupadd docker
sudo usermod -aG docker $USER

# Source zshrc (if using zsh)
if [[ "$SHELL" == */zsh ]]; then
  echo "Sourcing ~/.zshrc..."
  source ~/.zshrc || echo "Failed to source ~/.zshrc. Please check the file."
else
  echo "Not using zsh. Skipping ~/.zshrc sourcing."
fi

echo "Installation completed successfully."
