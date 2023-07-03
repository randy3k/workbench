#!/usr/bin/env bash

set -e

download_zip() {
    DIR=`mktemp -d`
    curl -sL -o "$DIR/workbench.zip" https://github.com/randy3k/workbench/archive/master.zip

    mkdir -p $HOME/.local/
    unzip -q -o $DIR/workbench.zip -d $HOME/.local/

    # remove any previous directory
    rm -rf $HOME/.local/workbench

    mv $HOME/.local/workbench-master $HOME/.local/workbench

    rm -r "$DIR"
}

git_clone() {
    mkdir -p $HOME/.local/

    # remove any previous directory
    rm -rf $HOME/.local/workbench

    git clone -q git@github.com:randy3k/workbench.git $HOME/.local/workbench
}

initialize_profile() {
    bash ~/.local/workbench/profile_init.sh
}


echo='Please choose a method: '
options=("download zip" "git clone" )
select opt in "${options[@]}"
do
    case $opt in
        "download zip")
            download_zip
            break
            ;;
        "git clone")
            git_clone
            break
            ;;
        "quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "Downloaded workbench."

echo "Initializing profile."
initialize_profile

echo "Installing workbench"
mkdir -p ~/.local/bin/
ln -sf ~/.local/workbench/workbench ~/.local/bin/workbench
