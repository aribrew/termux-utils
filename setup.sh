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


if ! [[ -d "$SCRIPTS" ]];
then
    mkdir -p "$SCRIPTS"
fi


if ! [[ -f "$HOME/.bashrc" ]];
then
    cp "$PREFIX/etc/bash.bashrc" "$HOME/.bashrc"
fi


if ! [[ -f "$HOME/.environment" ]];u
then
    touch "$HOME/.environment"
    echo "source \$HOME/.environment" >> "$HOME/.bashrc"
fi


if ! [[ -v TMP ]];
then
    if ! [[ -d $HOME/tmp ]];
    then
        mkdir -p $HOME/tmp
    fi

    export TMP=$HOME/tmp
fi


grep -q "\$HOME/scripts" "$HOME/.environment"


if ! [[ "$?" == "0" ]];
then
    echo "export PATH=\$HOME/scripts:\$PATH" >> "$HOME/.environment"

    export PATH=$HOME/scripts:$PATH
fi


if ! [[ -f "$HOME/scripts/bash_helpers.sh" ]];
then
    CDIR=$PWD
    cd $TMP
    
    curl -LO $BASH_HELPERS_URL

    if ! [[ "$?" == "0" ]];
    then
        abort "Failed downloading bash_helpers. Aborting."
    fi

    mv bash_helpers.sh "$SCRIPTS/"
    chmod +x "$SCRIPTS/bash_helpers.sh"
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


BASIC_PACKAGES="git openssh micro screen"


echo "Installing some basic packages if not yet available..."
echo "------------------------------------------------------"

pkg install -y $BASIC_PACKAGES


if ! [[ "$?" == "0" ]];
then
    abort "Failed."
fi


echo "Please enter a password for login from SSH"
echo ""

PASSWD_OK="1"

while ! [[ "$PASSWD_OK" == "0" ]];
do
    passwd
    PASSWD_OK=$?
done

echo ""
echo "Done. To change it, simply run 'passwd'."
echo ""

if ! [[ -d "$HOME/termux-utils" ]];
then
    echo ""
    echo "Cloning 'termux-utils' repository..."
    echo "------------------------------------"

    git clone $TERMUX_UTILS_URL "$HOME/termux-utils"


    if ! [[ "$?" == "0" ]];
    then
        echo "#!/bin/bash" >> "$HOME/download_termux-utils"

        echo "git clone $TERMUX_SETUP_URL \$HOME/termux-utils" \
        >> "$HOME/download_termux-utils"

        echo "chmod -R +x \"\$HOME/termux-utils\"" \
        >> "$HOME/download_termux-utils"

        chmod +x "$HOME/download_termux-utils"

        echo "Something went wrong cloning the repo."
        echo "You can retry executing '~/download_termux-utils'."
    fi
fi


if [ -d "$HOME/termux-utils" ];
then
    chmod -R 770 "$HOME/termux-utils"
fi


if [ -d "$HOME/storage/external-1" ];
then
    "$HOME/termux-utils/find_extsd"
fi


echo ""
echo "Basic Termux setup done."
echo "You can now setup more things using the scripts contained in the"
echo "repository downloaded in ~/termux-utils' if you wish."
echo ""
echo "Restart Termux before continuing."
echo ""


touch $HOME/.termux-setup_done

