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
    export HTTP_PROXY=http://http-proxy.ifam.fraunhofer.de:81
    export HTTPS_PROXY=http://http-proxy.ifam.fraunhofer.de:81
fi
echo update system
sudo apt update
sudo apt upgrade -y
echo copy config
cp -r .config/* ~/.config
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
