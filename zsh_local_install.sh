#!/bin/bash

# Script for installing zsh on systems where you don't have root access.
# zsh will be installed in $HOME/.local/bin
# It's asuumed that wget and a C/C++ compiler are installed

# exit on error
set -e

OLDWD=$PWD

ZSH_VERSION=5.0.2

mkdir -p $HOME/.local $HOME/zsh_tmp
cd $HOME/zsh_tmp

wget -O zsh-${ZSH_VERSION}.tar.bz2 http://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.bz2/download
tar jxvf zsh-${ZSH_VERSION}.tar.bz2
cd zsh-${ZSH_VERSION}
./configure --prefix=$HOME/.local --enable-multibyte --enable-pcre CFLAGS="-I$HOME/.local/include" LDFLAGS="-L$HOME/.local/lib -L$HOME/.local/include"
CPPFLAGS="-I$HOME/.local/include" LDFLAGS="-static -L$HOME/.local/include -L$HOME/.local/lib" make
make install

cd "$OLDWD"
rm -rf $HOME/zsh_tmp
echo "$HOME/.local/bin/zsh is now available. You can optionally add $HOME/.local/bin to your PATH."
