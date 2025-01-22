#!/usr/bin/env bash

set -e

case "$(uname -m)" in
   x86_64|x86-64|amd64|em64t|x64)
      _GEEKBENCH_SUFFIX="Linux";;
   arm64|aarch64|armv8*|armv9*)
      _GEEKBENCH_SUFFIX="LinuxARMPreview";;
   riscv64)
      _GEEKBENCH_SUFFIX="LinuxRISCVPreview";;
   *)
      echo "Unsupported arch: $ARCH" >&2
      exit 1
      ;;
esac

_GB_CDN="https://cdn.geekbench.com"
_GB5_NAME="Geekbench-5.5.1-$_GEEKBENCH_SUFFIX"
_GB6_NAME="Geekbench-6.3.0-$_GEEKBENCH_SUFFIX"

if [ ! -f "/tmp/$_GB5_NAME" ]; then
    if [ ! -f "/tmp/$_GB5_NAME.tar.gz" ]; then
        wget -O "/tmp/$_GB5_NAME.tar.gz.tmp" "$_GB_CDN/$_GB5_NAME.tar.gz" \
            && mv "/tmp/$_GB5_NAME.tar.gz.tmp" "/tmp/$_GB5_NAME.tar.gz"
    fi
    tar -xvf "/tmp/$_GB5_NAME.tar.gz" -C "/tmp"
fi

if [ ! -f "/tmp/$_GB6_NAME" ]; then
    if [ ! -f "/tmp/$_GB6_NAME.tar.gz" ]; then
        wget -O "/tmp/$_GB6_NAME.tar.gz.tmp" "$_GB_CDN/$_GB6_NAME.tar.gz" \
            && mv "/tmp/$_GB6_NAME.tar.gz.tmp" "/tmp/$_GB6_NAME.tar.gz"
    fi
    tar -xvf "/tmp/$_GB6_NAME.tar.gz" -C "/tmp"
fi

"/tmp/$_GB5_NAME/geekbench5"
"/tmp/$_GB6_NAME/geekbench6"
