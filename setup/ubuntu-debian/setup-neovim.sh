#!/bin/sh

curl -OL https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz &&
	tar -zxvf nvim-linux64.tar.gz &&
	sudo cp -r nvim-linux64/ /usr/local/ &&
	rm -rf nvim-linux64 &&
	rm nvim-linux64.tar.gz &&
	sudo ln -s /usr/local/nvim-linux64/bin/nvim /usr/bin/nvim &&
	source ~/.zshrc &&
	sudo apt-get install ripgrep &&
	sudo apt install fd-find &&
	sudo ln -s $(which fdfind) /usr/bin/fd &&
	sudo apt install gcc &&
	source ~/.zshrc
