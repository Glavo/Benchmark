#!/usr/bin/env bash

set -e

cd $(dirname $0)

export CC=gcc-14
export CXX=g++-14

THREADS=$(grep -c ^processor /proc/cpuinfo)
RESULT_DIR="$HOME/benchmark-result-$(date '+%F_%H%M%S')"
DATA_DIR="$PWD/data"

mkdir -p $RESULT_DIR

# FFmpeg

## Decode
cp "$DATA_DIR/Bosphorus_h264.mp4" /dev/shm
cp "$DATA_DIR/Bosphorus_h265.mp4" /dev/shm
ffmpeg -threads $THREADS -c:v h264 -i /dev/shm/Bosphorus_h264.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h264_decode.txt"
ffmpeg -threads $THREADS -c:v hevc -i /dev/shm/Bosphorus_h265.mp4 -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h265_decode.txt"
rm /dev/shm/Bosphorus_h264.mp4
rm /dev/shm/Bosphorus_h265.mp4

## Encode
if [ ! -z "$(ffmpeg -encoders 2>/dev/null | grep h264_omx)" ]; then
   unzstd -k -o /tmp/Bosphorus_3840x2160.y4m "$DATA_DIR/Bosphorus_3840x2160.y4m.zst"
   ffmpeg -i /tmp/Bosphorus_3840x2160.y4m -c:v h264_omx -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h264_encode.txt"

   if [ ! -z "$(ffmpeg -encoders 2>/dev/null | grep hevc_omx)" ]; then
      ffmpeg -i /tmp/Bosphorus_3840x2160.y4m -c:v hevc_omx -an -benchmark -f null - 2>&1 | tee "$RESULT_DIR/h265_encode.txt"
   fi
fi

# OpenSSL
opensslCiphers=(md5 sha1 sha256 sha512 des des-ede3 aes-128-cbc aes-192-cbc aes-256-cbc rsa2048 dsa2048)

openssl speed "${opensslCiphers[@]}" | tee "$RESULT_DIR/openssl_single.txt"
echo -e "\n" >> "$RESULT_DIR/openssl_single.txt"
openssl speed -evp sm3 | tee -a "$RESULT_DIR/openssl_single.txt"
echo -e "\n" >> "$RESULT_DIR/openssl_single.txt"
openssl speed -evp sm4 | tee -a "$RESULT_DIR/openssl_single.txt"

openssl speed -multi $THREADS "${opensslCiphers[@]}" | tee "$RESULT_DIR/openssl_multi.txt"
echo -e "\n" >> "$RESULT_DIR/openssl_multi.txt"
openssl speed -multi $THREADS -evp sm3 | tee -a "$RESULT_DIR/openssl_multi.txt"
echo -e "\n" >> "$RESULT_DIR/openssl_multi.txt"
openssl speed -multi $THREADS -evp sm4 | tee -a "$RESULT_DIR/openssl_multi.txt"

# 7z (https://www.7-cpu.com/)
7zz b '-mm=*' '-mmt=*' | tee "$RESULT_DIR/7z-benchmark.txt"
