#!/usr/bin/env bash

set -e

## Decode
cp "$DATA_DIR"/Bosphorus_*.mp4 /dev/shm
ffmpeg -threads "$THREADS" -c:v h264 -i /dev/shm/Bosphorus_h264.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h264_software_decode.txt"
ffmpeg -threads "$THREADS" -c:v hevc -i /dev/shm/Bosphorus_h265.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h265_software_decode.txt"

set +e

if [ -n "$H264_HARDWARE_DECODER" ]; then
  ffmpeg -c:v "$H264_HARDWARE_DECODER" -i /dev/shm/Bosphorus_h264.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h264_hardware_decode.txt"
fi

if [ -n "$H265_HARDWARE_DECODER" ]; then
  ffmpeg -c:v "$H265_HARDWARE_DECODER" -i /dev/shm/Bosphorus_h265.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h265_hardware_decode.txt"
fi

rm /dev/shm/Bosphorus_*.mp4

## Encode

#ffmpeg -i "/dev/shm/Bosphorus_3840x2160.y4m" -c:v "$H264_HARDWARE_ENCODER" -an -benchmark -pix_fmt yuv420p -f null - 2>&1 | tee "$RESULT_DIR/h264_hardware_encode.txt"
#ffmpeg -i "/dev/shm/Bosphorus_3840x2160.y4m" -c:v "$H265_HARDWARE_ENCODER" -an -benchmark -pix_fmt yuv420p -f null - 2>&1 | tee "$RESULT_DIR/h265_hardware_encode.txt"
