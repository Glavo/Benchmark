#!/usr/bin/env bash

set -e

GITHUB_SHA=d5fad6bd094899101a4e5fd53af7298160ced6ab

if [ ! -d "$CACHE_DIR/coremark" ]; then
  git clone https://github.com/eembc/coremark.git "$CACHE_DIR/coremark"
fi

mkdir -p "$RESULT_DIR/coremark"

cd "$CACHE_DIR/coremark"
git checkout $GITHUB_SHA

make clean && make
cp ./run1.log "$RESULT_DIR/coremark/threads-1.log"

make clean && make XCFLAGS="-DMULTITHREAD=$THREADS -DUSE_PTHREAD -pthread"
cp ./run1.log "$RESULT_DIR/coremark/threads-$THREADS.log"
