#!/usr/bin/env bash

# exit on error
set -e

mkdir -p ~/.ssh
chmod 700 ~/.ssh
curl -s https://github.com/randy3k.keys >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
