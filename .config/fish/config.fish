if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias lse='exa -lga --icons'
alias bat='batcat'
alias vi='nvim'

alias gc='git commit -m'
alias ga='git add'

alias py='python3'

set -gx EDITOR nvim
set -gx PROJECT_PATHS ~/git

function fish_greeting
    echo \((date +%T)\) Moin $USER auf $hostname
end
