#!/bin/bash

# exit on error
set -e

URL="https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4.5-linux-x86_64.tar.gz"
DIR=`mktemp -d`
wget "$URL" -O "$DIR/julia.tar.gz"
tar xzfv "$DIR/julia.tar.gz" -C "$DIR"
JULIADIR=`find "$DIR" -maxdepth 2 -name "julia*" -type d | head -n 1`
mv "$JULIADIR" "$HOME/.local/julia-v0.4.5"
ln -s "$HOME/.local/julia-v0.4.5/bin/julia" "$HOME/.local/bin/julia"
