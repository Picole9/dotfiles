#!/bin/bash

function check_installed() {
    if [ "installed" == "$(dpkg-query --show --showformat='${db:Status-Status}\n' $1)" ]; then
        echo $1 already installed
        return 1
    else
        return 0
    fi
}

if [ "$1" == "--proxy" ]; then
    export HTTP_PROXY=$2
    export HTTPS_PROXY=$2
fi

echo update system
sudo apt update
sudo apt upgrade -y
echo install bat \(cat\), exa {ls}, tldr {man}, ripgrep, fd-find
sudo apt install bat exa tldr rip-grep fd-find btop -y
echo copy config
cp -r .config/* ~/.config
echo installing glow
if check_installed "glow"; then
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update
    sudo apt install glow -y
fi
echo installing neovim
if check_installed "neovim"; then
    if [ "$1" == "--proxy" ]; then
        sudo -E add-apt-repository ppa:neovim-ppa/unstable -y
    else
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
    fi
    sudo apt update
    sudo apt install neovim universal-ctags -y
fi
echo installing fish
if check_installed "fish"; then
    if [ "$1" == "--proxy" ]; then
        sudo -E add-apt-repository ppa:fish-shell/release-3 -y
    else
        sudo add-apt-repository ppa:fish-shell/release-3 -y
    fi
    sudo apt update && sudo apt install fish -y
    sudo chsh -s /usr/bin/fish
fi
echo installing fisher
if [ "$1" == "--proxy" ]; then
    curl --proxy $2 -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
else
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fi
fisher update
