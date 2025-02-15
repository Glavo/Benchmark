#!/usr/bin/env bash

sudo adduser glavo && sudo usermod -aG sudo glavo && sudo su glavo

sudo apt update && sudo apt upgrade -y && \
sudo apt install -y \
    fish curl wget zstd lz4 xz-utils 7zip zip unzip ffmpeg zlib1g-dev screen neofetch mesa-utils \
    autoconf automake build-essential meson cmake ninja-build git pkg-config g++-14 \
    libass-dev libfreetype-dev libgnutls28-dev libmp3lame-dev libsdl2-dev libtool texinfo yasm \
    libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev \
    libvpx-dev libx264-dev libx265-dev libnuma-dev \
    libunistring-dev libaom-dev libdav1d-dev libopus-dev # libomxil-bellagio-dev

chsh -s /usr/bin/fish