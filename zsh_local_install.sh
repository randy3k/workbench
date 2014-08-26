#!/bin/bash

# Script for installing zsh on systems where you don't have root access.
# zsh will be installed in $HOME/.local/bin
# It's asuumed that wget and a C/C++ compiler are installed

# exit on error
set -e

OLDWD=$PWD

ZSH_VERSION=5.0.2
NCURSES_VERSION=5.9

mkdir -p $HOME/.local $HOME/zsh_tmp
cd $HOME/zsh_tmp

if [ ! -d $HOME/.local/include/ncurses ]; then
    tar xvzf ncurses-${NCURSES_VERSION}.tar.gz
    cd ncurses-${NCURSES_VERSION}
    ./configure --prefix=$HOME/.local
    make
    make install
    cd ..
fi


wget -O zsh-${ZSH_VERSION}.tar.bz2 http://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.bz2/download
tar jxvf zsh-${ZSH_VERSION}.tar.bz2
cd zsh-${ZSH_VERSION}
./configure --prefix=$HOME/.local --enable-multibyte --enable-pcre CFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-L$HOME/.local/lib -L$HOME/.local/include/ncurses -L$HOME/.local/include"
CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-static -L$HOME/.local/include -L$HOME/.local/include/ncurses -L$HOME/.local/lib" make
make install

cd $OLDWD
rm -rf $HOME/zsh_tmp
echo "$HOME/.local/bin/zsh is now available. You can optionally add $HOME/.local/bin to your PATH."
