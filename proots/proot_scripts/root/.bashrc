export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

if [[ "$PATH" == "" ]];
then
    export PATH=/sbin
else
    export PATH=$PATH:/sbin
fi

export PATH=$PATH:/bin
export PATH=$PATH:/usr/bin:/usr/local/bin
