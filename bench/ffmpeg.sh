#!/usr/bin/env bash

set -e

## Decode
cp "$DATA_DIR/Bosphorus_*.mp4" /dev/shm
ffmpeg -threads $THREADS -c:v h264 -i /dev/shm/Bosphorus_h264.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h264_decode.txt"
ffmpeg -threads $THREADS -c:v hevc -i /dev/shm/Bosphorus_h265.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h265_decode.txt"
rm /dev/shm/Bosphorus_*.mp4

set +e

if [ ! -z "$(cat /proc/cpuinfo | grep 'Raspberry Pi 4 Model B')" ]; then
   exit
fi

## Encode

if [ ! -z "$(ffmpeg -encoders 2>/dev/null | grep h264_omx)" ]; then
    ffmpeg -i "$DATA_DIR/Bosphorus_3840x2160.y4m" -c:v h264_omx -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h264_encode.txt"
fi

if [ ! -z "$(ffmpeg -encoders 2>/dev/null | grep hevc_omx)" ]; then
    ffmpeg -i "$DATA_DIR/Bosphorus_3840x2160.y4m" -c:v hevc_omx -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h265_encode.txt"
fi
