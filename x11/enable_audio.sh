#!/bin/bash

if ! [[ -v AUDIO_ENV_LOADED ]];
then
    echo "PulseAudio environment isn't loaded."
    echo ""
else
    echo -n "Enabling audio ... "
    screen -dmS audio_server pulseaudio --start \
                                        --load="$PULSEAUDIO_OPTS" \
                                        --exit-idle-time=-1

    if ! [[ "$?" == "0" ]];
    then
        echo "Failed!"
        echo ""

        exit 1
    fi

    echo "Done."
    echo ""
fi
