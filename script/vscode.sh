#!/usr/bin/env bash

set -e

DIR=$(mktemp -d)

curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output $DIR/vscode_cli.tar.gz
tar -xf $DIR/vscode_cli.tar.gz -C ~/.local/bin/
