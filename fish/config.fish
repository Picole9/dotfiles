if status is-interactive
    # Commands to run in interactive sessions can go here
end

# .. to cd ../, ... to cd ../../ etc.
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

alias l='eza -lga --icons'
if test (cat /etc/os-release | grep -i debian)
    alias bat='batcat --paging=never'
    alias bathelp='batcat --plain --language=help'
else
    alias bat='bat --paging=never'
    alias bathelp='bat --plain --language=help'
end
alias t='tmux'

# expands !! to the last history item
function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

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
alias dcl='docker compose logs -f --tail 100'
alias dce='docker compose exec'
alias dcb='docker compose build'
alias dprune='docker system prune -a'

# git
alias gc='git commit -m'
alias gcr='git reset --soft HEAD~1'
alias ga='git add'
alias gs='git status'
alias gdt='git difftool'
alias gpull='git pull --rebase'
alias gpush='git push'
function gd
    if test (cat /etc/os-release | grep -i debian)
        git diff --name-only --relative --diff-filter=d $argv | xargs batcat --diff
    else
        git diff --name-only --relative --diff-filter=d $argv | xargs bat --diff
    end
end

# python
alias py='python'

function pyenv -d "create venv"
    python3 -m venv .venv
    source .venv/bin/activate.fish
    if test -e "requirements.txt"
        pip install -r requirements.txt
    end
end

function pyrun -d "run python script in venv"
    if test -n "$VIRTUAL_ENV"
        deactivate
    end
    set pydir (dirname $argv[1])
    if test -e "$pydir/.venv/"
        source $pydir/.venv/bin/activate.fish
        python3 $argv
        deactivate
    else
        echo "no virtual_env found"
    end
end

function auto_activate_venv --on-variable PWD -d "auto-activate venv if exists on change-directory"
    set REPO_ROOT (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$REPO_ROOT"; and test -n "$VIRTUAL_ENV"
        deactivate
    end
    if [ "$VIRTUAL_ENV" = "$REPO_ROOT/.venv" ]
        return
    end
    if [ -d "$REPO_ROOT/.venv" ]
        source "$REPO_ROOT/.venv/bin/activate.fish" &>/dev/null
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

function sudo
    if functions -q $argv[1]
        set argv fish -c "$argv"
    end
    command sudo $argv
end
