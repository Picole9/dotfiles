#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish neovim universal-ctags
chsh -s /usr/bin/fish
cp .config ~/.config
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf update
