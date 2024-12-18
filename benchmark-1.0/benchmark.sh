#!/usr/bin/bash

threadsCount=$(grep -c ^processor /proc/cpuinfo)
export CC=gcc-14
export CXX=g++-14

echo "Threads: $threadsCount"
