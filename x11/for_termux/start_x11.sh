#!/bin/bash

source bash_helpers.sh

if ! [[ -v BASH_HELPERS_LOADED ]];
then
    echo -e "BASH Helpers not found in PATH. Install it first.\n"
    exit 1
fi


SCRIPT_HOME=$(realpath $(dirname $0))


if ! [[ -v X11_ENV_LOADED ]];
then
    source "$SCRIPT_HOME/for_termux/.x11_env"
fi


echo -n "Starting X11 server ..."

screen -dmS x11 termux-x11 :0

if ! [[ "$?" == "0" ]];
then
    abort "Failed!"
fi


echo "Done."
echo ""