#!/usr/bin/env sh

set -x #echo on

MESSAGE="Bor start moved to bor.sevice, do not call this file!"
echo "${MESSAGE}"
TIMESTAMP=$(date "+%H:%M:%S %d-%m-%Y")
echo "${TIMESTAMP} ${MESSAGE} >> /home/ubuntu/bor-start-error.log"
