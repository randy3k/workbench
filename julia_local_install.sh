#!/bin/bash

# exit on error
set -e

OLDWD=$PWD
cd $HOME/julia_tmp

cd $HOME/.local
git clone https://github.com/JuliaLang/julia
cd julia
git checkout v0.3.1
echo 'OPENBLAS_DYNAMIC_ARCH = 0' >> Make.user
make -j8

ln -s $HOME/.local/julia/julia $HOME/.local/bin/julia

cd "$OLDWD"
echo "$HOME/.local/bin/julia is now available. You can optionally add $HOME/.local/bin to your PATH."
