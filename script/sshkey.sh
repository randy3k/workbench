#!/usr/bin/env bash

# exit on error
set -e

mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlSzqV7Bu/ARTcSqjh3A4ND5OESYBmHtOMdRl1Tey8m" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
