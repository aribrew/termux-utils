#!/bin/bash

source "$HOME/.x11_env"

echo -n "Starting X11 server ..."
screen -dmS x11 termux-x11 :0

if ! [[ "$?" == "0" ]];
then
    echo "Failed!"
    echo ""

    exit 1
fi

sleep 3

echo "Done."
echo ""