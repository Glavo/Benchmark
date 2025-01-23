#!/usr/bin/env bash

set -e

RENAISSANCE_VERSION="0.16.0"
RENAISSANCE_JAR_NAME="renaissance-gpl-$RENAISSANCE_VERSION.jar"

if [ ! -f "$CACHE_DIR/$RENAISSANCE_JAR_NAME" ]; then
    wget -O "$CACHE_DIR/$RENAISSANCE_JAR_NAME.tmp" "https://github.com/renaissance-benchmarks/renaissance/releases/download/v$RENAISSANCE_VERSION/$RENAISSANCE_JAR_NAME"
    mv "$CACHE_DIR/$RENAISSANCE_JAR_NAME.tmp" "$CACHE_DIR/$RENAISSANCE_JAR_NAME"
fi

# TODO