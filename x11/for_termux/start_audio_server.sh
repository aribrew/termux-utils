#!/bin/bash

source bash_helpers.sh

if ! [[ -v BASH_HELPERS_LOADED ]];
then
    echo -e "BASH Helpers not found in PATH. Install it first.\n"
    exit 1
fi


SCRIPT_HOME=$(realpath $(dirname $0))


if ! [[ -v AUDIO_ENV_LOADED ]];
then
    source "$SCRIPT_HOME/for_termux/.audio_env"
fi

echo -n "Enabling audio ... "

screen -dmS audio_server pulseaudio --start \
                                    --load="$PULSEAUDIO_OPTS" \
                                    --exit-idle-time=-1

if ! [[ "$?" == "0" ]];
then
    abort "Failed!"
fi

echo "Done."
echo ""
