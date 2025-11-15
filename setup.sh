#!/bin/bash

SCRIPT_PATH=$(realpath $(dirname $0))


if ! [[ -v BASH_HELPERS_LOADED ]];
then
    source bash_helpers.sh
    
    if ! [[ "$?" == "0" ]];
    then
        "$SCRIPT_PATH/bash_helpers.sh" --install

        source $("$SCRIPT_PATH/bash_helpers.sh" --path)
    fi
fi




if ! [[ -v TERMUX_VERSION ]];
then
    abort "This script must be used in Termux only."
fi


if [[ -f "$HOME/.termux-utils_path" ]];
then
    abort "Termux utils setup was already completed."
fi


TERMUX_UTILS_URL="https://github.com/aribrew/termux-utils.git"


echo "=================================="
echo "Performing a basic Termux setup..."
echo "=================================="


USER_SCRIPTS=$HOME/.local/bin


if ! [[ -d "$USER_SCRIPTS" ]];
then
    mkdir -p "$USER_SCRIPTS"
fi


if ! [[ -f "$HOME/.bashrc" ]];
then
    cp "$PREFIX/etc/bash.bashrc" "$HOME/.bashrc"
fi


if ! [[ -f "$HOME/.environment" ]];
then
    touch "$HOME/.environment"
    echo "source \$HOME/.environment" >> "$HOME/.bashrc"
fi


echo ""
echo "Updating Termux ..."
echo "-------------------"


pkg update

if ! [[ "$?" == "0" ]];
then
    abort "Failed refreshing package database."
fi


pkg upgrade -y


BASIC_PACKAGES="termux-services git openssh micro screen which mandoc "
BASIC_PACKAGES+="ranger libusb clang termux-api"


echo ""
echo "Installing some basic packages if not yet available..."
echo "------------------------------------------------------"

pkg install -y $BASIC_PACKAGES


if ! [[ "$?" == "0" ]];
then
    abort "Failed."
fi

echo ""


if ! [[ -f "$HOME/.ssh_password_set" ]];
then
    echo "Please enter a password for login from SSH"
    echo ""

    PASSWD_OK="1"

    while ! [[ "$PASSWD_OK" == "0" ]];
    do
        passwd
        PASSWD_OK=$?
    done

    touch "$HOME/.ssh_password_set"

    echo "To change it, simply run 'passwd'."
    echo ""
fi


if ! [[ -d "$HOME/termux-utils" ]];
then
    echo ""
    echo "Cloning 'termux-utils' repository..."
    echo "------------------------------------"

    git clone $TERMUX_UTILS_URL "$HOME/termux-utils"


    if ! [[ "$?" == "0" ]];
    then
        abort "Failed. You can run dl_termux-utils.sh to do it manually."
    fi
fi


if [[ -d "$HOME/termux-utils" ]];
then
    chmod -R 770 "$HOME/termux-utils"
fi


if [[ -d "$HOME/storage/external-1" ]];
then
    "$HOME/termux-utils/find_extsd"
fi


echo "source \"$SCRIPT_PATH/.termux_env\"" >> "$HOME/.environment"


echo ""
echo "Basic Termux setup done."
echo ""
echo "You can now setup more things using the scripts contained in the"
echo "repository downloaded in ~/termux-utils if you wish."
echo ""
echo "The ~/.termux_env will prepare the environment every time you log in."
echo "Also, it will load an extra ~/.user_env, if exists, where you can add"
echo "any configuration you want."
echo ""
echo "Restart Termux before continuing."
echo ""


echo "$SCRIPT_PATH" > $HOME/.termux-utils_path

