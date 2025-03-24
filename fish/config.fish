if status is-interactive
    # Commands to run in interactive sessions can go here
end

# get OS
set OS (awk -F= '/^ID_LIKE=/{print $2}' /etc/os-release | tr -d '"')

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

if command -v eza >/dev/null
    alias l='eza -lga --icons'
else if command -v exa >/dev/null
    alias l='exa -lga --icons'
end

switch $OS
    case debian
        alias bat='batcat'
end
alias py='python3'
alias nsl='nslookup'
alias bathelp='bat --plain --language=help'
alias cat='bat --plain --paging=never'

# vi
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
alias dprune='docker system prune -a --volumes'

# kubernetes
alias k='kubectl'
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
        case debian
            git diff --name-only --relative --diff-filter=d $argv | xargs batcat --diff
        case '*'
            git diff --name-only --relative --diff-filter=d $argv | xargs bat --diff
    end
end

# vi mode
function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert -m default jk backward-char force-repaint
end

alias wetter='curl https://wttr.in/Bremen'

set -gx EDITOR nvim
set -gx PROJECT_PATHS ~/git ~/.config/

fish_add_path $HOME/.local/bin

function fish_greeting
    echo \((date +%T)\) Moin $USER auf $hostname
end

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
    command sudo $argv
end
