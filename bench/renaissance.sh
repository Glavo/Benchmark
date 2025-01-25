#!/usr/bin/env bash

set -e

RENAISSANCE_VERSION="0.16.0"
RENAISSANCE_JAR_NAME="renaissance-gpl-$RENAISSANCE_VERSION.jar"
VM_OPTIONS="-Xms6g -Xmx6g"
BENCHMARKS=(dotty)
RENAISSANCE_RESULT_DIR="$RESULT_DIR/renaissance"

if [ ! -f "$CACHE_DIR/$RENAISSANCE_JAR_NAME" ]; then
    wget -O "$CACHE_DIR/$RENAISSANCE_JAR_NAME.tmp" "https://github.com/renaissance-benchmarks/renaissance/releases/download/v$RENAISSANCE_VERSION/$RENAISSANCE_JAR_NAME"
    mv "$CACHE_DIR/$RENAISSANCE_JAR_NAME.tmp" "$CACHE_DIR/$RENAISSANCE_JAR_NAME"
fi

mkdir -p "$RENAISSANCE_RESULT_DIR"

for BENCHMARK in "${BENCHMARKS[@]}"; do
    java $VM_OPTIONS -jar "$CACHE_DIR/$RENAISSANCE_JAR_NAME" --json "$RENAISSANCE_RESULT_DIR/$BENCHMARK.json" | tee "$RENAISSANCE_RESULT_DIR/$BENCHMARK.log"
done
