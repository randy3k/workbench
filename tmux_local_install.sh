#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/.local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

OLDWD=$PWD

TMUX_VERSION=1.9
TMUX_SUBVERSION=1.9a
LIBEVENT_VERSION=2.0.21
NCURSES_VERSION=5.9

# create our directories
mkdir -p $HOME/.local $HOME/tmux_tmp
cd $HOME/tmux_tmp

# download source files for tmux, libevent, and ncurses
wget -O tmux-${TMUX_VERSION}.tar.gz http://sourceforge.net/projects/tmux/files/tmux/tmux-${TMUX_VERSION}/tmux-${TMUX_SUBVERSION}.tar.gz/download
wget https://github.com/downloads/libevent/libevent/libevent-${LIBEVENT_VERSION}-stable.tar.gz
wget http://ftp.gnu.org/pub/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz

# extract files, configure, and compile

############
# libevent #
############
tar xvzf libevent-${LIBEVENT_VERSION}-stable.tar.gz
cd libevent-${LIBEVENT_VERSION}-stable
./configure --prefix=$HOME/.local --disable-shared
make
make install
cd ..

############
# ncurses  #
############
tar xvzf ncurses-${NCURSES_VERSION}.tar.gz
cd ncurses-${NCURSES_VERSION}
./configure --prefix=$HOME/.local
make
make install
cd ..

############
# tmux     #
############
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_SUBVERSION}
./configure CFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-L$HOME/.local/lib -L$HOME/.local/include/ncurses -L$HOME/.local/include"
CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-static -L$HOME/.local/include -L$HOME/.local/include/ncurses -L$HOME/.local/lib" make
cp tmux $HOME/.local/bin


# cleanup
cd $OLDWD
rm -rf $HOME/tmux_tmp

echo "$HOME/.local/bin/tmux is now available. You can optionally add $HOME/.local/bin to your PATH."
