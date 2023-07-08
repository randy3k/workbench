#!/usr/bin/env bash

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E19F5F87128899B192B1A2C2AD5F960A256A04AF

echo "deb http://cran.rstudio.com/bin/linux/debian stretch-cran35/" | tee /etc/apt/sources.list.d/r-project.list

apt-get upgrade
apt-get install r-base
