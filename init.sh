#!/usr/bin/env bash

cd $(dirname $0)

export CC=gcc-14
export CXX=g++-14
export THREADS=$(grep -c ^processor /proc/cpuinfo)
export RESULT_DIR="$PWD/result-$(date '+%F_%H%M%S')"
export DATA_DIR="$PWD/data"
export BENCH_DIR="$PWD/bench"

mkdir -p $RESULT_DIR

echo "PLATFROM: $(uname -a)"
echo "THREADS: $THREADS"
echo "RESULT_DIR: $RESULT_DIR"
echo "DATA_DIR: $DATA_DIR"
echo "BENCH_DIR: $BENCH_DIR"
