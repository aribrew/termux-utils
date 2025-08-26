#!/bin/bash

source "$HOME/.x11_env"

echo "Stopping running X11 server ..."
kill -9 $(pgrep -f "termux-x11") 2> /dev/null

echo "Stopping running Pulseaudio server ..."
kill -9 $(pgrep -f "pulseaudio") 2> /dev/null


echo "Enabling audio ..."

PULSEAUDIO_OPTS="module-native-protocol-tcp "
PULSEAUDIO_OPTS+="auth-ip-acl=127.0.0.1 auth-anonymous=1"

pulseaudio --start --load=$PULSEAUDIO_OPTS --exit-idle-time=-1


echo "Starting X11 server ..."
termux-x11 :0 &> /dev/null &

X11_AVAILABLE=$?
#if ! [[ "$?" == "0" ]];
#then
    
#fi

sleep 3

dbus-launch --exit-with-session xfce4-session &> /dev/null

DESKTOP_AVAILABLE=$?

if [[ "$X11_AVAILABLE" == "0" ]] && [[ "$DESKTOP_AVAILABLE" == "0" ]];
then
    echo "Desktop available. Open Termux:X11 app."
fi
