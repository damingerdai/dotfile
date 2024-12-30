#!/bin/bash

# Define default parameters
VERSION="0.10.2"
MIRROR="https://github.com/neovim/neovim/releases/download"
CUSTOM_MIRROR="https://ghp.ci/https://github.com/neovim/neovim/releases/download"
NERD_FONTS_URL="https://github.com/ryanosais/nerd_fonts/releases/download/v3.3.0/JetBrainsMono.zip"

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
  NERD_FONTS_DOWNLOAD_URL="$NERD_FONTS_URL"
else
  DOWNLOAD_URL="$MIRROR/v$VERSION/nvim-linux64.tar.gz"
  NERD_FONTS_DOWNLOAD_URL="$MIRROR/$NERD_FONTS_URL"
fi

# Download, extract, and install
curl -OL "$DOWNLOAD_URL" &&
  tar -zxvf nvim-linux64.tar.gz &&
  sudo cp -r nvim-linux64/ /usr/local/ &&
  rm -rf nvim-linux64 &&
  rm nvim-linux64.tar.gz &&
  sudo ln -s /usr/local/nvim-linux64/bin/nvim /usr/bin/nvim

# Install auxiliary tools
sudo apt-get install ripgrep fd-find fzf gcc
sudo ln -s $(which fdfind) /usr/bin/fd

NERD_FONTS_DIR="$HOME/.fonts"
mkdir -p "$NERD_FONTS_DIR"

echo "Downloading JetBrainsMono Nerd Fonts."
if curl -L "$NERD_FONTS_DOWNLOAD_URL" -o "$NERD_FONTS_DIR/JetBrainsMono.zip"; then
  echo "Install JetBrainsMono"
  unzip "$NERD_FONTS_DIR/JetBrainsMono.zip"
  fc-cache -fv
else
  echo "Failed to download JetBrainsMono. Please check your internet connection and URL."
fi

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
