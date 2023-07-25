#!/bin/bash

function check_installed() {
    if [ "installed" == "$(dpkg-query --show --showformat='${db:Status-Status}\n' $1)" ]; then
        echo $1 already installed
        return 1
    else
        return 0
    fi
}

echo update system
sudo apt update
sudo apt upgrade -y
echo install bat, exa
sudo apt install bat exa -y
echo copy config
cp -r .config ~/.config
echo installing glow
if check_installed "glow"; then
    sudo mkdir -p /etc/apt/keyrings
    if [ "$1" == "--proxy" ]; then
        curl -fsSL --proxy $2 https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    else
        curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    fi
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update
    sudo apt install glow -y
fi
echo installing neovim
if check_installed "neovim"; then
    if [ "$1" == "--proxy" ]; then
        sudo -E add-apt-repository ppa:neovim-ppa/stable
    else
        sudo add-apt-repository ppa:neovim-ppa/stable
    fi
    sudo apt update
    sudo apt install neovim universal-ctags -y
fi
echo installing fish
if check_installed "fish"; then
    if [ "$1" == "--proxy" ]; then
        sudo -E apt-add-repository ppa:fish-shell/release-3
    else
        sudo apt-add-repository ppa:fish-shell/release-3
    fi
    sudo apt update && sudo apt install fish -y
    chsh -s /usr/bin/fish
fi
#echo installing omf
#if [ "$1" == "--proxy" ]; then
#curl --proxy $2 https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
#else
#curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
#fi
#omf update
