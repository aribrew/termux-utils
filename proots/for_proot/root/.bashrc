# Basic .bashrc for Termux root user

export SHELL="/bin/bash"
export LS_OPTIONS="--color=auto"
eval "$(dircolors)"

alias ls="ls $LS_OPTIONS"
alias ll="ll $LS_OPTIONS -l"
alias l="ls $LS_OPTIONS -lA"

export PATH=$PATH:/opt/bin
