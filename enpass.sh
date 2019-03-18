#! /bin/env bash -l

set -e

echo "deb https://apt.enpass.io/ stable main" > /etc/apt/sources.list.d/enpass.list

curl https://apt.enpass.io/keys/enpass-linux.key | apt-key add -
