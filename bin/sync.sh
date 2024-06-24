#!/bin/bash

SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
cd $SCRIPTPATH
ROOTPATH=$( cd "$SCRIPTPATH/.." ; pwd -P )
cd $ROOTPATH

source ./src/loader.sh

if [[ $SERVER_LIVE -eq 1 ]]; then
  echo "It shouldn't be run on live server"
  exit 1
fi

bash ./bin/get-live-db.sh 2>&1
