#!/bin/bash

source bash_helpers.sh

if ! [[ -v BASH_HELPERS_LOADED ]];
then
    echo -e "BASH Helpers not found in PATH. Install it first.\n"
    exit 1
fi


if [[ "$TERMUX_VERSION" == "" ]];
then
    abort "This script is intended for Termux only."
fi


if [[ -f "$PREFIX/bin/termux-x11" ]];
then
    abort "X11 already installed."
fi


echo "Refreshing package database..."
echo "------------------------------"

pkg update


if ! [[ -f "$PREFIX/etc/apt/sources.list.d/tur.list" ]];
then
    echo ""
    echo "Installing Termux User Repository ..."
    echo "-------------------------------------"
    
    pkg install tur-repo -y
fi


if ! [[ -f "$PREFIX/etc/apt/sources.list.d/x11.list" ]];
then
    echo ""
    echo "Installing X11 repository ..."
    echo "-----------------------------"

    pkg install x11-repo -y
fi


if ! [[ -f "$PREFIX/bin/termux-x11" ]];
then
    echo ""
    echo "Installing Termux X11 server..."
    echo "-------------------------------"

    pkg install termux-x11-nightly -y
fi

