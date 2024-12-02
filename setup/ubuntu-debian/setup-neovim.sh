#!/bin/bash

# Define default parameters
VERSION="0.10.2"
MIRROR="https://github.com/neovim/neovim/releases/download"
CUSTOM_MIRROR="https://ghp.ci/https://github.com/neovim/neovim/releases/download"

# Parse command-line arguments
while getopts ":v:m:" opt; do
  case $opt in
  v)
    VERSION="$OPTARG"
    ;;
  m)
    MIRROR="$OPTARG"
    ;;
  \?)
    echo "Invalid option: -$OPTARG" >&2
    exit 1
    ;;
  :)
    echo "Option -$OPTARG requires an argument." >&2
    exit 1
    ;;
  esac
done

# Construct download URL based on arguments
if [[ -z "$MIRROR" ]]; then
  DOWNLOAD_URL="$CUSTOM_MIRROR/v$VERSION/nvim-linux64.tar.gz"
else
  DOWNLOAD_URL="$MIRROR/v$VERSION/nvim-linux64.tar.gz"
fi

# Download, extract, and install
curl -OL "$DOWNLOAD_URL" &&
  tar -zxvf nvim-linux64.tar.gz &&
  sudo cp -r nvim-linux64/ /usr/local/ &&
  rm -rf nvim-linux64 &&
  rm nvim-linux64.tar.gz &&
  sudo ln -s /usr/local/nvim-linux64/bin/nvim /usr/bin/nvim

# Install auxiliary tools
sudo apt-get install ripgrep fd-find gcc
sudo ln -s $(which fdfind) /usr/bin/fd

# Source .zshrc to update environment variables
source ~/.zshrc

# curl -OL https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz &&
# 	tar -zxvf nvim-linux64.tar.gz &&
# 	sudo cp -r nvim-linux64/ /usr/local/ &&
# 	rm -rf nvim-linux64 &&
# 	rm nvim-linux64.tar.gz &&
# 	sudo ln -s /usr/local/nvim-linux64/bin/nvim /usr/bin/nvim &&
# 	source ~/.zshrc &&
# 	sudo apt-get install ripgrep &&
# 	sudo apt install fd-find &&
# 	sudo ln -s $(which fdfind) /usr/bin/fd &&
# 	sudo apt install gcc &&
# 	source ~/.zshrc
#
