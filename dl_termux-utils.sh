#!/bin/bash

TERMUX_UTILS_REPO="https://github.com/aribrew/termux-utils.git"


if ! [[ -d "$HOME/termux-utils" ]];
then
    pkg update

    if [[ "$?" == "0" ]];
    then
        pkg install -y git

        if [[ "$?" == "0" ]];
        then
            git clone $TERMUX_UTILS_REPO $HOME/termux-utils --depth 1

            if [[ "$?" == "0" ]];
            then
                echo "Termux Utils downloaded in ~/termux-utils."
                echo "Run ~/termux-utils/setup now."
                echo ""
            fi
        fi
    fi
fi
