#!/bin/bash

source bash_helpers.sh


if [[ "$TERMUX_VERSION" == "" ]];
then
    abort "This script is intended for Termux only."
fi


PROOT_NAME=$1


