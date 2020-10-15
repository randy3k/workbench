#!/bin/bash

REPO="workbench"

download_zip() {
    DIR=`mktemp -d`
    curl -sL -o "$DIR/$REPO.zip" https://github.com/randy3k/$REPO/archive/master.zip

    mkdir -p $HOME/.local/
    unzip -q -o $DIR/$REPO.zip -d $HOME/.local/

    # remove any previous directory
    rm -rf $HOME/.local/$REPO

    mv $HOME/.local/$REPO-master $HOME/.local/$REPO

    rm -r "$DIR"
}

git_clone() {
    mkdir -p $HOME/.local/

    # remove any previous directory
    rm -rf $HOME/.local/$REPO

    git clone -q --no-checkout git@github.com:randy3k/$REPO.git $HOME/.local/$REPO
}

initialize_profile() {
    bash ~/.local/$REPO/profile_init.sh
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

echo "Initializing profile"
initialize_profile

echo "Symlink script"
mkdir -p ~/.local/bin/
ln -s ~/.local/$REPO/$REPO ~/.local/bin/$REPO
