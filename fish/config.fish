if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ..='cd ..'
alias ...='cd ../..'
alias l='exa -lga --icons'
alias bat='batcat --paging=never'
alias fd='fdfind'
alias t='tmux'

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
alias gd='git diff'
alias gdt='git difftool'
alias gp='git push'

# python
alias python='python3'
alias py='python3'

alias wetter='curl https://wttr.in/Bremen'

set -gx EDITOR nvim
set -gx PROJECT_PATHS ~/git ~/.config/

function fish_greeting
    echo \((date +%T)\) Moin $USER auf $hostname
end

if test -e ~/.config/fish/localconf.fish
    source ~/.config/fish/localconf.fish
end