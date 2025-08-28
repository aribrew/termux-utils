#!/bin/bash


abort()
{
    MESSAGE=$1

    if ! [[ "$MESSAGE" == "" ]];
    then
        echo "$MESSAGE"
        echo ""
    fi

    exit 1
}




if ! [[ -v TERMUX_VERSION ]];
then
    abort "This script must be used in Termux only."
fi


if [[ -f "$HOME/.termux-setup_done" ]];
then
    abort "Termux setup has been already done."
fi


TERMUX_UTILS_URL="https://github.com/aribrew/termux-utils.git"

BASH_HELPERS_URL="https://gist.github.com/aribrew"
BASH_HELPERS_URL+="/2d6dd4036716952a64691bc2cbfa2e5c/raw/"
BASH_HELPERS_URL+="/b4408bf19273279a26729ac3e9a4bf988ab3b618/"
BASH_HELPERS_URL+="/bash_helpers.sh"


echo "=================================="
echo "Performing a basic Termux setup..."
echo "=================================="


SCRIPT_PATH=$(realpath $(dirname $0))
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


if ! [[ -f "$USER_SCRIPTS/bash_helpers.sh" ]];
then
    CDIR=$PWD
    cd $TMPDIR
    
    curl -LO $BASH_HELPERS_URL

    if ! [[ "$?" == "0" ]];
    then
        abort "Failed downloading bash_helpers.sh. Aborting."
    fi

    mv bash_helpers.sh "$USER_SCRIPTS/"
    chmod +x "$USER_SCRIPTS/bash_helpers.sh"
fi


export PATH=$USER_SCRIPTS:$PATH
source bash_helpers.sh


echo ""
echo "Updating Termux ..."
echo "-------------------"


pkg update

if ! [[ "$?" == "0" ]];
then
    abort "Failed refreshing package database."
fi


pkg upgrade -y


BASIC_PACKAGES="termux-services git openssh micro screen which mandoc"
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
fi


echo "To change it, simply run 'passwd'."
echo ""

sv-enable sshd


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


#cp "$SCRIPT_PATH/termux_files/.termux_env" $HOME/

#echo "export PATH=$USER_SCRIPTS:\$PATH" >> "$HOME/.termux_env"

#echo "source \$HOME/.termux_env" >> "$HOME/.environment"
echo "source \"$SCRIPT_PATH/.termux_env\"" >> "$HOME/.environment"


echo ""
echo "Basic Termux setup done."
echo ""
echo "You can now setup more things using the scripts contained in the"
echo "repository downloaded in ~/termux-utils' if you wish."
echo ""
echo "The ~/.termux_env will prepare the environment every time you log in."
echo "Also, it will load an extra ~/.user_env, if exists, where you can add"
echo "any configuration you want."
echo ""
echo "Restart Termux before continuing."
echo ""


touch $HOME/.termux-setup_done

