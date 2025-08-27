#!/bin/bash

SCRIPT_HOME=$(realpath $(dirname $0))


source "$HOME/.midi_env"


if [[ "$(which fluidsynth)" == "" ]];
then
    echo "Install fluidsynth first."
    echo ""

    exit 1
fi


echo -n "Enabling MIDI server ... "
screen -dmS midi_server fluidsynth $FLUIDSYNTH_OPTS


if ! [[ "$?" == "0" ]];
then
    echo "Failed!"
    echo ""

    exit 1
fi

echo "Done."
echo ""

