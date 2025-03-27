#!/bin/bash

echo "stop docker service"
systemctl stop docker docker.socket containerd

echo "remove docker package"
apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
apt-get purge docker.io

echo "remove docker data"
rm -rf /var/lib/docker
rm -rf /var/lib/containerd

echo "remove docker config"
rm -rf /etc/docker
rm -rf ~/.docker

echo "remove docker compose"
apt-get purge docker-compose
rm -f /usr/local/bin/docker-compose
apt-get purge docker-compose-plugin

echo "check docker"
docker --version
