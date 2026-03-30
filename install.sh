#!/usr/bin/env bash

set -e

install_dependencies() {
    local deps=("git" "zip" "vim" "curl")
    local missing=()
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            missing+=("$dep")
        fi
    done

    if [ ${#missing[@]} -eq 0 ]; then
        return
    fi

    read -p "Install missing dependencies (${missing[*]})? [y/N] " -r choice
    if [[ "$choice" =~ ^[yY]$ ]]; then
        if command -v apt-get >/dev/null; then
            sudo apt-get update
            sudo apt-get install -y "${missing[@]}"
        else
            echo "Warning: Package manager not recognized. Please ensure ${missing[*]} are installed."
        fi
    else
        echo "Skipping dependency installation."
    fi
}

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

install_dependencies

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
