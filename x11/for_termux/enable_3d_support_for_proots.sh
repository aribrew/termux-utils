#!/bin/bash

if ! [[ -v 3D_ENV_LOADED ]];
then
    source "$HOME/termux-utils/x11/for_termux/.3d_env"
fi


VIRGL_OPTS="--use-egl-surfaceless"

if ! [[ -v ZINK_COMPATIBILITY ]];
then
    VIRGL_OPTS+=" --use-gles"
fi


virgl_test_server $VIRGL_OPTS &

echo -e "3D acceleration should be enabled now for proots.\n"

