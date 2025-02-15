#!/bin/bash

# Define default parameters
VERSION="0.10.2"
MIRROR="https://github.com/neovim/neovim/releases/download"
CUSTOM_MIRROR="https://ghp.ci/https://github.com/neovim/neovim/releases/download"
NERD_FONTS_URL="https://github.com/ryanosais/nerd_fonts/releases/download/v3.3.0/JetBrainsMono.zip"
NVIM_DIR="/usr/bin/nvim"
NVIM_REAL_DIR="/usr/local/bin/nvim-linux64"
BACKUP_NVIM_REAL_DIR="/usr/local/bin/nvim-linux64-bak"

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

# check if the nvim directory exists
if [ -d "$NVIM_REAL_DIR"]; then
  # check if the backup nvim directory already exists
  if [ -d "$BACKUP_NVIM_REAL_DIR"]; then
    echo "Backup directory $BACKUP_NVIM_REAL_DIR already exists. Remove it"
    sudo rm -r -f "${BACKUP_NVIM_REAL_DIR}"
    if [ $? -eq 0]; then
      echo "Directory $NVIM_REAL_DIR has been successfully moved to $BACKUP_NVIM_REAL_DIR"
    else
      echo "Failed to move the directory $NVIM_REAL_DIR to $BACKUP_NVIM_REAL_DIR"
      exit 1
    fi
  fi
else
  echo "Directory $NVIM_REAL_DIR does not exist. No action"
fi

echo "Downloading Neovim from ${DOWNLOAD_URL}..."
curl -OL "$DOWNLOAD_URL" || {
  echo "Downloading failed! Exiting"
  exit 1
}

echo "Extracting Neovim to ${NVIM_REAL_DIR}"
sudo tar -C /usr/local -zxvf nvim-linux64.tar.gz || {
  echo "Extraction field! Exiting."
  exit 1
}

rm -r -f nvim-linux64.tar.gz

# Delete the backup directory after moving
echo "Deleting $BACKUP_NVIM_REAL_DIR"
sudo rm -rf "$BACKUP_NVIM_REAL_DIR"
if [ $? -eq 0 ]; then
  echo "Backup directory $BACKUP_NVIM_REAL_DIR has been successfully deleted."
else
  echo "Failed to delete $BACKUP_NVIM_REAL_DIR after moving"
  exit 1
fi

# check NVIM_DIR
if [ -L $NVIM_DIR ]; then
  echo "$NVIM_DIR exists. Skip it"
else
  echo "$NVIM_DIR does not exists. Create it"
  sudo ln -s "${NVIM_REAL_DIR}/bin/nvim" "${NVIM_DIR}"
fi

# Download, extract, and install
# curl -OL "$DOWNLOAD_URL" &&
#   tar -zxvf nvim-linux64.tar.gz &&
#   sudo cp -r nvim-linux64/ /usr/local/ &&
#   rm -rf nvim-linux64 &&
#   rm nvim-linux64.tar.gz &&
#   sudo ln -s /usr/local/nvim-linux64/bin/nvim /usr/bin/nvim

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

check_and_install_make() {
  if command -v make &>/dev/null; then
    echo "make exists"
  else
    echo "install make"
    sudo apt update
    sudo install -y make
    if command -v make &>/dev/null; then
      echo "make 安装成功。"
    else
      echo "make 安装失败，请手动检查。"
      exit 1
    fi
  fi
}

check_and_install_make

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
