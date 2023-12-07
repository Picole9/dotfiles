# dotfiles
Sammlung von configs, installieren via ansible
Installation von ansible via `sh install.sh`
Installieren der config `ansible-playbook playbooks/common.yaml -i hosts --ask-become-pass`

## roles:
* common: fishshell, nvim, ...
* server: docker, qemu-guest-agent(proxmox)
* update
