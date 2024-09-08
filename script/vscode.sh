#!/usr/bin/env bash

set -e

DIR=$(mktemp -d)

ARCH=$(uname -m)
if [[ "$ARCH" = "arm" ]]; then
    URL='https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-arm64'
elif [[ "$ARCH" = "arm" ]]; then
    URL='https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-arm32'
else
    URL='https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64'
end

curl -Lk $URL --output $DIR/vscode_cli.tar.gz
tar -xf $DIR/vscode_cli.tar.gz -C ~/.local/bin/

