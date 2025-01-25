#!/usr/bin/env bash

set -e

RENAISSANCE_VERSION="0.16.0"
RENAISSANCE_JAR_NAME="renaissance-gpl-$RENAISSANCE_VERSION.jar"
VM_OPTIONS="-Xms6g -Xmx6g"
BENCHMARKS=(als chi-square dec-tree gauss-mix log-regression movie-lens naive-bayes page-rank \
  akka-uct fj-kmeans reactors \
  db-shootout neo4j-analytics \
  future-genetic mnemonics par-mnemonics rx-scrabble scrabble \
  dotty philosophers scala-doku scala-kmeans scala-stm-bench7 \
  finagle-chirper finagle-http)
RENAISSANCE_RESULT_DIR="$RESULT_DIR/renaissance"

if [ ! -f "$CACHE_DIR/$RENAISSANCE_JAR_NAME" ]; then
    wget -O "$CACHE_DIR/$RENAISSANCE_JAR_NAME.tmp" "https://github.com/renaissance-benchmarks/renaissance/releases/download/v$RENAISSANCE_VERSION/$RENAISSANCE_JAR_NAME"
    mv "$CACHE_DIR/$RENAISSANCE_JAR_NAME.tmp" "$CACHE_DIR/$RENAISSANCE_JAR_NAME"
fi

mkdir -p "$RENAISSANCE_RESULT_DIR"

set +e

for BENCHMARK in "${BENCHMARKS[@]}"; do
    java $VM_OPTIONS -jar "$CACHE_DIR/$RENAISSANCE_JAR_NAME" --json "$RENAISSANCE_RESULT_DIR/$BENCHMARK.json" "$BENCHMARK" 2>&1 | tee "$RENAISSANCE_RESULT_DIR/$BENCHMARK.log"
done
