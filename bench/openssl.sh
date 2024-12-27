#!/usr/bin/env bash

opensslCiphers=(md5 sha1 sha256 sha512 des des-ede3 aes-128-cbc aes-192-cbc aes-256-cbc rsa2048 dsa2048)

# Single Thread

_SINGLE_RESULT="$RESULT_DIR/openssl_single.txt"
openssl speed "${opensslCiphers[@]}" | tee "$_SINGLE_RESULT"
echo -e "\n" >> "$_SINGLE_RESULT"
openssl speed -evp sm3 | tee -a "$_SINGLE_RESULT"
echo -e "\n" >> "$_SINGLE_RESULT"
openssl speed -evp sm4 | tee -a "$_SINGLE_RESULT"

# Multi Threads
_MULTI_RESULT="$RESULT_DIR/openssl_multi.txt"
openssl speed -multi $THREADS "${opensslCiphers[@]}" | tee "$_MULTI_RESULT"
echo -e "\nSM3:" >> "$_MULTI_RESULT"
openssl speed -multi $THREADS -evp sm3 | tee -a "$_MULTI_RESULT"
echo -e "\nSM4:" >> "$_MULTI_RESULT"
openssl speed -multi $THREADS -evp sm4 | tee -a "$_MULTI_RESULT"