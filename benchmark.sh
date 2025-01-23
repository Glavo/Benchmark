#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
source "$PWD/init.sh"

set +e

if [[ $# -gt 0 ]]; then
    for name in "$@"; do
        bash "$PWD/bench/$name.sh"
    done
else
    # bash $PWD/bench/geekbench.sh
    bash "$PWD/bench/ffmpeg.sh"
    bash "$PWD/bench/openssl.sh"
    bash "$PWD/bench/7z.sh"
    bash "$PWD/bench/coremark.sh"
fi
