#!/usr/bin/bash

THREADS=$(grep -c ^processor /proc/cpuinfo)
export CC=gcc-14
export CXX=g++-14

FFMPEG_BIN_DIR="$HOME/ffmpeg_build/bin"

$FFMPEG_BIN_DIR/ffmpeg -threads $THREADS -c:v hevc -i Bosphorus_h264.mp4 -an -benchmark -f null - 2>&1 | tee h264_decode.txt
$FFMPEG_BIN_DIR/ffmpeg -threads $THREADS -c:v hevc -i Bosphorus_h265.mp4 -an -benchmark -f null - 2>&1 | tee h265_decode.txt

