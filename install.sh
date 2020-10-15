#!/usr/bin/env bash

NAME="workbench"

download_zip() {
    DIR=`mktemp -d`
    curl -sL -o "$DIR/$NAME.zip" https://github.com/randy3k/$NAME/archive/master.zip

    mkdir -p $HOME/.local/
    unzip -q -o $DIR/$NAME.zip -d $HOME/.local/

    # remove any previous directory
    rm -rf $HOME/.local/$NAME

    mv $HOME/.local/$NAME-master $HOME/.local/$NAME

    rm -r "$DIR"
}

git_clone() {
    mkdir -p $HOME/.local/

    # remove any previous directory
    rm -rf $HOME/.local/$NAME

    git clone -q git@github.com:randy3k/$NAME.git $HOME/.local/$NAME
}

initialize_profile() {
    bash ~/.local/$NAME/profile_init.sh
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
ln -sf ~/.local/$NAME/$NAME ~/.local/bin/$NAME
