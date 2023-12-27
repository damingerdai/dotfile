#!/bin/sh

curl -fsSL get.docker.com -o- get-docker.sh | bash

curl -L https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-linux-x86_64 >/usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

source ~/.zshrc
