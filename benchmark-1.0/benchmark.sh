#!/usr/bin/bash

THREADS=$(grep -c ^processor /proc/cpuinfo)
export CC=gcc-14
export CXX=g++-14
