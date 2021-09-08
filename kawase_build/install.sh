#!/bin/bash

git clone https://github.com/GabrielTenma/compton-kawase-blur.git

cd compton-kawase-blur

# install depends
sudo apt install build-essential g++ libxcomposite-dev libxdamage-dev libxrandr-dev libxinerama-dev libconfig-dev libdbus-1-dev libdrm-dev libgl-dev asciidoc-base

# make
make

# install
sudo make install

cd -

