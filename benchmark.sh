#!/usr/bin/env bash

set -e

cd $(dirname $0)
source $PWD/init.sh

set +e

# bash $PWD/bench/geekbench.sh
bash $PWD/bench/ffmpeg.sh
bash $PWD/bench/openssl.sh
bash $PWD/bench/7z.sh
