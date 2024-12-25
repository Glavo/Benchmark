#!/usr/bin/bash





FFMPEG_BUILD_DIR="$HOME/Build/ffmpeg"
FFMPEG_BIN_DIR="$FFMPEG_BUILD_DIR/bin"
FFMPEG_VERSION="7.1"

export CC=gcc-14
export CXX=g++-14

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
  --enable-libaom \
  --enable-libass \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-omx \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree && \
PATH="$FFMPEG_BIN_DIR:$PATH" make && \
make install && \
hash -r