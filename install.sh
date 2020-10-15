#!/bin/bash

REPO="bootstrap"

download_bootstrap() {
    DIR=`mktemp -d`
    curl -L -o "$DIR/bootstrap.zip" https://github.com/randy3k/$REPO/archive/master.zip

    mkdir -p $HOME/.local/
    unzip -q -o $DIR/bootstrap.zip -d $HOME/.local/

    rm -rf $HOME/.local/bootstrap
    mv $HOME/.local/$REPO-master $HOME/.local/bootstrap

    rm -r "$DIR"
}

clone_bootstrap() {
    git clone --no-checkout git@github.com:randy3k/$REPO.git $HOME/.local/bootstrap.tmp
    mv $HOME/.local/bootstrap.tmp/.git $HOME/.local/bootstrap/

    rm -rf $HOME/.local/bootstrap.tmp
    cd $HOME/.local/bootstrap
    git reset
}

initialize_profile() {
    curl -s https://raw.githubusercontent.com/randy3k/$REPO/master/profile_init.sh | bash
}



PS3='Please choose a method: '
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
ln -s ~/.local/bootstrap/bootstrap ~/.local/bin/bootstrap
