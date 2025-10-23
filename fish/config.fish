if status is-interactive
    # Commands to run in interactive sessions can go here
end

# get OS
set OS (awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')

# .. to cd ../, ... to cd ../../ etc.
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# expands !! to the last history item
function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

# l for eza/exa
if command -v eza >/dev/null
    alias l='eza -lga --icons'
    alias lt='eza -aT --level 3 --icons'
else if command -v exa >/dev/null
    alias l='exa -lga --icons'
    alias lt='exa -aT --level 3 --icons'
end

switch $OS
    case ubuntu
        alias bat='batcat'
end
alias py='python3'
alias uvr='uv run'
alias nsl='nslookup'
alias cat='bat --plain --paging=never'
alias jctl='journalctl -p 3 -xb'
alias space='df -h'
alias spacedir='du -sh *'

# vi
set -gx EDITOR nvim
set -gx VISUAL nvim
alias vi='nvim'
function vissh -d "oil-ssh://$argv"
    nvim oil-ssh://$argv
end

# docker
alias dc='docker compose'
alias dcps='docker compose ps'
alias dcd='docker compose down'
alias dcu='docker compose up -d --remove-orphans'
alias dcr='docker compose up -d --force-recreate'
alias dcl='docker compose logs -f --tail 100'
alias dce='docker compose exec'
alias dcb='docker compose build'
alias dcs='docker compose stats'
alias dcp='docker compose pull'
alias dip="docker ps -q | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /'"
alias dprune='docker system prune -a --volumes'

# kubernetes
alias k='kubecolor'
alias mk='minikube'

# git
alias gc='git commit -m'
alias gcr='git reset HEAD~1'
alias ga='git add'
alias gs='git status'
alias gdt='git difftool'
alias gpull='git pull --rebase'
alias gp='git push'
alias gpush='git push'
function gd
    switch $OS
        case ubuntu
            git diff --name-only --relative --diff-filter=d $argv | xargs batcat --diff
        case '*'
            git diff --name-only --relative --diff-filter=d $argv | xargs bat --diff
    end
end

# wireguard
alias wgu='wg-quick up wg0'
alias wgd='wg-quick down wg0'

# vi mode
function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert -m default jk backward-char force-repaint
end

switch $OS
    case manjaro
        alias mirror='pacman-mirrors -c Germany'
    case cachyos
        alias mirror='cachyos-rate-mirrors'
end

alias wetter='curl https://wttr.in/Bremen'

# pj-plugin
set -gx PROJECT_PATHS ~/git ~/.config/

# fzf
if command -v fzf >/dev/null
    fzf --fish | source
end

# zoxide
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# man
abbr -a --position anywhere -- --help '--help | bat -plhelp'
abbr -a --position anywhere -- -h '-h | bat -plhelp'
set -gx MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# Append common directories for executable files to $PATH
fish_add_path $HOME/.local/bin

# greeting
function fish_greeting
    echo \((date +%T)\) Moin $USER auf $hostname
end

# additional config in localconf.fish
if test -e ~/.config/fish/localconf.fish
    source ~/.config/fish/localconf.fish
end

function get_cert -d "get x509 cert from url; get_cert {domain} [port:443]"
    set domain $argv[1]
    if test (count $argv) -gt 1
        set port "$argv[2]"
    else
        set port 443
    end
    set -l cert_file (echo | openssl s_client -connect $domain:$port 2>/dev/null | openssl x509)
    if test -n "$cert_file"
        echo "$cert_file"
    else
        echo "Failed to fetch the certificate."
        return 1
    end
    while read --nchars 1 -l save_cert -P 'Do you want to save the certificate to /etc/ssl/ca-cert? (y/n)' or return 1
        switch $save_cert
            case y Y
                if not test -d /etc/ssl/ca-cert
                    sudo mkdir -p /etc/ssl/ca-cert
                end
                echo | openssl s_client -connect $domain:$port 2>/dev/null | openssl x509 >/etc/ssl/ca-cert/$domain.crt
                cat /etc/ssl/ca-cert/$domain.crt | sudo tee -a /etc/ssl/certs/ca-certificates.crt >/dev/null
                if test $status -eq 0
                    echo "Certificate saved to /etc/ssl/ca-cert/$domain.crt"
                else
                    echo "Failed to save the certificate. Please check your permissions."
                    return 1
                end
                break
            case n N
                echo "Certificate not saved."
                break
            case '*'
                echo no valid input
                continue
        end
    end
end

# wait for ssh
function ssh_wait
    set success 1 # Startwert, damit die Schleife läuft
    while test $success -ne 0
        ssh $argv
        set success $status
        if test $success -ne 0
            sleep 5
        end
    end
end

function sudo
    if functions -q $argv[1]
        set argv fish -c "$argv"
    end
    command sudo -sE $argv
end
