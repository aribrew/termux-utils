#!/bin/bash

source bash_helpers.sh

if ! [[ -v BASH_HELPERS_LOADED ]];
then
    echo -e "BASH Helpers not found in PATH. Install it first.\n"
    exit 1
fi


X11_APP_URL="https://github.com/termux/termux-x11"
X11_APP_URL+="/releases/download/nightly/"


THIS_ARCH=$(uname -m)


if [[ "$THIS_ARCH" == "aarch64" ]];
then
    X11_APP_URL+="app-arm64-v8a-debug.apk"
else
    X11_APP_URL+="app-armeabi-v7a-debug.apk"
fi


echo "Proceeding to install Termux:X11 app..."
echo "---------------------------------------"

echo "TODO"
