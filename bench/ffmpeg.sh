#!/usr/bin/env bash

set -e

## Decode
cp "$DATA_DIR"/Bosphorus_*.mp4 /dev/shm
ffmpeg -threads "$THREADS" -c:v h264 -i /dev/shm/Bosphorus_h264.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h264_decode.txt"
ffmpeg -threads "$THREADS" -c:v hevc -i /dev/shm/Bosphorus_h265.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h265_decode.txt"
rm /dev/shm/Bosphorus_*.mp4

set +e

## Encode

if [ "$(uname -m)" = "riscv64" ]; then
    H264_ENCODER='h264_omx'
    H265_ENCODER='hevc_omx'
elif [ -n "$(lspci | grep 'UHD Graphics')" ]; then
    H264_ENCODER=h264_qsv
    H265_ENCODER=hevc_qsv
else
    exit
fi

ffmpeg -i "$DATA_DIR/Bosphorus_3840x2160.y4m" -c:v "$H264_ENCODER" -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h264_encode.txt"
ffmpeg -i "$DATA_DIR/Bosphorus_3840x2160.y4m" -c:v "$H265_ENCODER" -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h265_encode.txt"
