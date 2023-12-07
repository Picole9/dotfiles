#!/bin/bash

sudo apt update
sudo apt install python3-pip -y
pip3 install ansible
# ansible-galaxy collection install community.general
# ansible-galaxy collection install community.docker
