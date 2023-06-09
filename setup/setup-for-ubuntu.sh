#!/bin/sh

sudo apt update -y && sudo apt upgrade -y

sudo apt install zsh -y

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

echo 'alias ll="ls -alF"' >> ~/.zshrc
echo 'alias rm="rm -i"' >> ~/.zshrc

sudo chsh -s /bin/zsh

zsh