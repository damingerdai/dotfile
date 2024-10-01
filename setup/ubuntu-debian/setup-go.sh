#!/bin/sh

curl -OL https://golang.org/dl/go1.23.0.linux-amd64.tar.gz && sudo tar -C /usr/local -xvf go1.23.0.linux-amd64.tar.gz && echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.zshrc && source ~/.zshrc
# curl -OL https://golang.google.cn/dl/go1.23.0.linux-amd64.tar.gz && sudo tar -C /usr/local -xvf go1.23.0.linux-amd64.tar.gz && echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc && source ~/.zshrc
