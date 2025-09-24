#!/bin/bash

source bash_helpers.sh

SCRIPT_HOME=$(realpath $(dirname $0))


if ! [[ -v AUDIO_ENV_LOADED ]];
then
    source "$SCRIPT_HOME/.audio_env"
else
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
fi
