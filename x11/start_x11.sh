#!/bin/bash

source bash_helpers.sh

SCRIPT_HOME=$(realpath $(dirname $0))


if ! [[ -v X11_ENV_LOADED ]];
then
    source "$SCRIPT_HOME/.x11_env"
fi


echo -n "Starting X11 server ..."
screen -dmS x11 termux-x11 :0

if ! [[ "$?" == "0" ]];
then
    abort "Failed!"
fi

sleep 3

echo "Done."
echo ""