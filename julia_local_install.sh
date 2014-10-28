#!/bin/bash

# exit on error
set -e

OLDWD=$PWD
cd $HOME/julia_tmp

cd $HOME/.local
git clone https://github.com/JuliaLang/julia
cd julia
git checkout v0.3.2
echo 'OPENBLAS_DYNAMIC_ARCH = 0' >> Make.user
make -j8
make install prefix=~/.local/julia-0.3.2

ln -sf $HOME/.local/julia-0.3.2/bin/julia $HOME/.local/bin/julia

cd "$OLDWD"
echo "$HOME/.local/bin/julia is now available. You can optionally add $HOME/.local/bin to your PATH."
