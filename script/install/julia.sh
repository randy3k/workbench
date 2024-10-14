#!/usr/bin/env bash

# exit on error
set -e

if [[ "$1" = "dev" ]]; then
    URL="https://status.julialang.org/download/linux-x86_64"
    JULIA="julia-dev"
else
    URL=$(curl -s "https://julialang.org/downloads/" | sed -n 's/.*href="\([^"]*x86_64\.tar\.gz\)".*/\1/p')
    JULIA="julia"
fi
echo Downloading from $URL

DIR=`mktemp -d`
wget "$URL" -O "$DIR/julia.tar.gz"
tar xzfv "$DIR/julia.tar.gz" -C "$DIR"
JULIADIR=`find "$DIR" -maxdepth 2 -name "julia*" -type d | head -n 1`
[[ -d "$HOME/.local/$JULIA" ]] && rm -rf "$HOME/.local/$JULIA"
mv "$JULIADIR" "$HOME/.local/$JULIA"
ln -sf "$HOME/.local/$JULIA/bin/julia" "$HOME/.local/bin/$JULIA"
rm -r "$DIR"
