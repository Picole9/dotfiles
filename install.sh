#!/bin/bash
echo update system
sudo apt update
sudo apt upgrade -y
echo install needed programs
sudo apt install bat exa -y
echo copy config
cp .config ~/.config
echo installing glow
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update
sudo apt install glow -y
echo installing neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim universal-ctags -y
echo installing fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update && sudo apt install fish -y
chsh -s /usr/bin/fish
echo installing omf
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf update
