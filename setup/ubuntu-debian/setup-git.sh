#!/bin/sh
set -e

user_email="mingguobin@live.com"
user_name="damingerdai"

sudo apt update -y && sudo apt upgrade -y && sudo apt install git -y

git config --global user.email "$user_email"
git config --global user.name "$user_name"

echo "Git configured successfully."
