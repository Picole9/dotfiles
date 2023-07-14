#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish neovim universal-ctags
chsh -s /usr/bin/fish
cp .config ~/.config
# omf
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf update
# glow
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install glow
