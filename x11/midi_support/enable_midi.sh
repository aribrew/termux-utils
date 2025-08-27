#!/bin/bash

SCRIPT_HOME=$(realpath $(dirname $0))


source "$HOME/.midi_env"


if ! [[ "$TERMUX_VERSION" == "" ]];
then
    SOUNDFONT="$SCRIPT_HOME/GeneralUser-GS.sf2"
else
    echo "TODO: Find system's soundfont."
fi


FLUIDSYNTH_OPTS="-a alsa -m alsa_seq -l "
FLUIDSYNTH_OPTS+="-s \"$SOUNDFONT\""


if [[ "$(which fluidsynth)" == "" ]];
then
    echo "Install fluidsynth first."
    echo ""

    exit 1
fi


if ! [[ -f "$SOUNDFONT" ]];
then
    echo "Cannot find the desired soundfont '$SOUNDFONT'."
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

