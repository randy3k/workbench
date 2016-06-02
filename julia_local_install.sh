#!/bin/bash

# exit on error
set -e

URL=$(curl -s "http://julialang.org/downloads/" | sed -n 's/.*href="\([^"]*x86_64\.tar\.gz\)".*/\1/p')
DIR=`mktemp -d`
wget "$URL" -O "$DIR/julia.tar.gz"
tar xzfv "$DIR/julia.tar.gz" -C "$DIR"
JULIADIR=`find "$DIR" -maxdepth 2 -name "julia*" -type d | head -n 1`
rm -rf "$HOME/.local/julia"
mv "$JULIADIR" "$HOME/.local/julia"
ln -sf "$HOME/.local/julia/bin/julia" "$HOME/.local/bin/julia"
rm -r "$DIR"
