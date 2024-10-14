#!/usr/bin/env bash

CODENAME=$(grep VERSION_CODENAME /etc/os-release | cut -d'=' -f2)

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E19F5F87128899B192B1A2C2AD5F960A256A04AF

echo "deb http://cloud.r-project.org/bin/linux/debian $CODENAME-cran40/" | tee /etc/apt/sources.list.d/r-project.list

sudo apt-get upgrade
sudo apt-get install r-base
