#!/usr/bin/env sh

set -x #echo on

. $HOME/launch/mainnet-v1/variables.sh

MESSAGE="Bor start moved to bor.sevice, do not call this file!"
echo "${MESSAGE}"
TIMESTAMP=$(date "+%H:%M:%S %d-%m-%Y")
echo "${TIMESTAMP} ${MESSAGE} >> ${MOUNT_DATA_DIR}/bor-start-incorrect.log"
