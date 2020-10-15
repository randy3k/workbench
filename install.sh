#!/bin/bash

REPO="unix-bootstrap"

download_bootstrap() {
    DIR=`mktemp -d`
    curl -sL -o "$DIR/bootstrap.zip" https://github.com/randy3k/$REPO/archive/master.zip

    mkdir -p $HOME/.local/
    unzip -q -o $DIR/bootstrap.zip -d $HOME/.local/

    rm -rf $HOME/.local/bootstrap
    mv $HOME/.local/$REPO-master $HOME/.local/bootstrap

    rm -r "$DIR"
}

clone_bootstrap() {
    git clone -q --no-checkout git@github.com:randy3k/$REPO.git $HOME/.local/bootstrap.tmp
    mkdir -p $HOME/.local/bootstrap
    mv $HOME/.local/bootstrap.tmp/.git $HOME/.local/bootstrap/

    rm -rf $HOME/.local/bootstrap.tmp
    cd $HOME/.local/bootstrap
    git reset
}

initialize_profile() {
    bash ~/.local/bootstrap/profile_init.sh
}


echo='Please choose a method: '
options=("download zip" "git clone" )
select opt in "${options[@]}"
do
    case $opt in
        "download zip")
            download_bootstrap
            break
            ;;
        "git clone")
            clone_bootstrap
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

echo "Symlink bootstrap"
mkdir -p ~/.local/bin/
ln -s ~/.local/bootstrap/bootstrap ~/.local/bin/bootstrap
