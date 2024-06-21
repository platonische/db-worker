#!/bin/bash

SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
cd $SCRIPTPATH
ROOTPATH=$( cd "$SCRIPTPATH/.." ; pwd -P )
cd $ROOTPATH

source ./src/loader.sh

DATE=$(date '+%Y%m%d')
FILENAME="${DATE}${DB_DUMP_FILE_SUFFIX}"

bash bin/db-dump.sh $FILENAME