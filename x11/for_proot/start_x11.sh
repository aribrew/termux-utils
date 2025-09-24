#!/bin/bash

if [[ -f "$HOME/.audio_env" ]];
then
    source "$HOME/.audio_env"
fi


if [[ -f "$HOME/.x11_env" ]];
then
    source "$HOME/.x11_env"
fi


screen -dmS desktop startxfce4


echo "XFCE4 desktop should be running. Check 'desktop' screen for output."
echo ""

