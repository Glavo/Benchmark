#!/usr/bin/env bash

set -e

sysbench --test=cpu run | tee "$RESULT_DIR/sysbench.log"