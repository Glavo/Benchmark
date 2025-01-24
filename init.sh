#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

if [ -z "$RESULT_DIR" ]; then
    export CC=gcc-14
    export CXX=g++-14
    export THREADS="$(grep -c ^processor /proc/cpuinfo)"
    export RESULT_DIR="$PWD/results/$(date '+%F_%H%M%S')"
    export DATA_DIR="$PWD/data"
    export CACHE_DIR="$PWD/cache"

    mkdir -p "$RESULT_DIR"
    mkdir -p "$CACHE_DIR"

    echo "PLATFROM: $(uname -a)"
    echo "THREADS: $THREADS"
    echo "RESULT_DIR: $RESULT_DIR"
    echo "DATA_DIR: $DATA_DIR"
fi
