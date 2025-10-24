#!/bin/bash

source bash_helpers.sh

if ! [[ -v BASH_HELPERS_LOADED ]];
then
    echo -e "BASH helpers not found in PATH. Install it first.\n"
    exit 1
fi


if ! [[ -f "$PREFIX/bin/proot-distro" ]];
then
    echo "Installing proot-distro ..."
    echo "---------------------------"

    pkg install -y proot-distro

    if ! [ "$?" == "0" ];
    then
        echo ""
        abort "Failed!"
    fi
fi
