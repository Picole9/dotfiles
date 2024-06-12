if status is-interactive
    # Commands to run in interactive sessions can go here
end

# .. to cd ../, ... to cd ../../ etc.
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

alias l='exa -lga --icons'
alias bat='bat --paging=never'
alias t='tmux'

# expands !! to the last history item
function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

# vi
alias vi='nvim'
function vissh
    nvim oil-ssh://$argv
end

# docker
alias dc='docker compose'
alias dcl='docker compose ps'
alias dcd='docker compose down'
alias dcu='docker compose up -d --remove-orphans'
alias dprune='docker system prune -a'
alias dlog='docker compose logs -f'

# git
alias gc='git commit -m'
alias ga='git add'
alias gac='git reset'
alias gs='git status'
alias gdt='git difftool'
alias gp='git push'
function gd
    git diff --name-only --relative --diff-filter=d $argv | xargs bat --diff
end

# python
alias python='python3'
alias py='python3'

function pyenv
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
