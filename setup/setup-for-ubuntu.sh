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

curl -OL https://golang.org/dl/go1.21.0.linux-amd64.tar.gz && sudo tar -C /usr/local -xvf go1.21.0.linux-amd64.tar.gz && echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc && source ~/.zshrc
# curl -OL https://golang.google.cn/dl/go1.21.0.linux-amd64.tar.gz && sudo tar -C /usr/local -xvf go1.21.0.linux-amd64.tar.gz && echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc && source ~/.zshrc

sudo apt-get install unzip
curl -OL https://github.com/MordechaiHadad/bob/releases/download/v2.4.1/bob-linux-x86_64.zip && sudo unzip bob-linux-x86_64.zip -d /usr/local/bin && sudo chmod -R 755 /usr/local/bin/bob && source ~/.zshrc
