#!/bin/bash

SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
cd $SCRIPTPATH
ROOTPATH=$( cd "$SCRIPTPATH/.." ; pwd -P )
cd $ROOTPATH

source ./src/loader.sh

if [[ $SERVER_LIVE eq 1 ]]; then
  echo "It shouldn't be run on live server"
  exit 1
fi

if [[ $SYNC_BY_SSH eq 1 ]]; then
  AUTH="${SOURCE_SSH_USER}@${SOURCE_SSH_HOST}"
  SSH_DOOR="ssh -t ${AUTH}"
  FILENAME="$($SSH_DOOR \"cd ${SOURCE_FOLDER} && bash ${SOURCE_DUMP_TOOL_SCRIPT};\" 2>&1)"
  `scp ${AUTH}:${SOURCE_FOLDER}/${SOURCE_PATH_TO_DUMP}/${FILENAME} ${DB_STORAGE_FOLDER}/`

  exit 0
fi

