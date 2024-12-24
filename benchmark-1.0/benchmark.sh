#!/usr/bin/bash

THREADS=$(grep -c ^processor /proc/cpuinfo)
export CC=gcc-14
export CXX=g++-14

BENCHMARK_DIR="$HOME/benchmark-$(date '+%F_%H%M%S')"
FFMPEG_BIN_DIR="$HOME/ffmpeg_build/bin"

mkdir -p $BENCHMARK_DIR

# FFmpeg
ffmpeg -threads $THREADS -c:v hevc -i Bosphorus_h264.mp4 -an -benchmark -f null - 2>&1 | tee "$BENCHMARK_DIR/h264_decode.txt"
ffmpeg -threads $THREADS -c:v hevc -i Bosphorus_h265.mp4 -an -benchmark -f null - 2>&1 | tee "$BENCHMARK_DIR/h265_decode.txt"

# OpenSSL
opensslCiphers=(md5 sha1 sha256 sha512 des des-ede3 aes-128-cbc aes-192-cbc aes-256-cbc rsa2048 dsa2048)
openssl speed "${opensslCiphers[@]}" | tee "$BENCHMARK_DIR/openssl_single.txt"
openssl speed -multi "$threadsCount" "${opensslCiphers[@]}" | tee "$BENCHMARK_DIR/openssl_multi.txt"

# 7z (https://www.7-cpu.com/)
7zz b -mm=* -mmt=* | tee "$BENCHMARK_DIR/7z-benchmark.txt"
