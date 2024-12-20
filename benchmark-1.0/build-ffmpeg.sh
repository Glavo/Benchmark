#!/usr/bin/bash

sudo apt install \
  autoconf automake build-essential cmake git-core libass-dev \
  libfreetype6-dev libgnutls28-dev libmp3lame-dev libsdl2-dev libtool \
  libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev \
  meson ninja-build pkg-config texinfo wget yasm zlib1g-dev \
  libunistring-dev libaom-dev libdav1d-dev libopus-dev

FFMPEG_BUILD_DIR="$HOME/ffmpeg_build"
FFMPEG_BIN_DIR="$FFMPEG_BUILD_DIR/bin"
FFMPEG_VERSION="7.1"

cd /tmp && \
wget -O "ffmpeg-$FFMPEG_VERSION.tar.xz" "https://ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.xz" && \
tar xvf "ffmpeg-$FFMPEG_VERSION.tar.xz" && \
cd "ffmpeg-$FFMPEG_VERSION" && \
PATH="$FFMPEG_BIN_DIR:$PATH" PKG_CONFIG_PATH="$FFMPEG_BUILD_DIR/lib/pkgconfig" ./configure \
  --prefix="$FFMPEG_BUILD_DIR" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$FFMPEG_BUILD_DIR/include" \
  --extra-ldflags="-L$FFMPEG_BUILD_DIR/lib" \
  --extra-libs="-lpthread -lm" \
  --cc=$CC \
  --cxx=$CXX \
  --ld=$CXX \
  --bindir="$FFMPEG_BIN_DIR" \
  --enable-gpl \
  --enable-gnutls \
  --enable-libass \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-omx \
  --enable-nonfree && \
PATH="$FFMPEG_BIN_DIR:$PATH" make && \
make install && \
hash -r