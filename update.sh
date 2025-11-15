#!/bin/bash

SCRIPT_HOME=$(realpath $(dirname $0))

cd "$SCRIPT_HOME"

echo -e "Updating Termux utils with repository...\n"

git pull

if [[ "$?" == "0" ]];
then
    echo -e "Failed. Check you have git installed."
    echo -e "Also, check your Internet connection."
    echo -e "If all is OK... maybe the repo has a problem.\n"
fi
