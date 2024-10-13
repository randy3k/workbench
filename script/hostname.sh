#!/usr/bin/env bash

# exit on error
set -e

HOSTNAME=$HOSTNAME

read -p 'New hostname: ' NEWHOSTNAME
sudo hostnamectl hostname $NEWHOSTNAME
sudo sed -i "s/\\(127.*\\s*\\)$HOSTNAME/\\1$NEWHOSTNAME/g" /etc/hosts
