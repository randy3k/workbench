#!/bin/bash

# exit on error
set -e

JULIA_VER=0.4.0

OLDWD=$PWD
cd $HOME/.local
git clone https://github.com/JuliaLang/julia || (
  cd julia
  make cleanall
  git checkout master
  git reset
  git pull
)
cd julia
git checkout "v$JULIA_VER"
echo 'OPENBLAS_DYNAMIC_ARCH = 0' >> Make.user
make -j8
make install prefix=~/.local/julia-v$JULIA_VER

ln -sf $HOME/.local/julia-v$JULIA_VER/bin/julia $HOME/.local/bin/julia

cd "$OLDWD"
echo "$HOME/.local/bin/julia is now available. You can optionally add $HOME/.local/bin to your PATH."
