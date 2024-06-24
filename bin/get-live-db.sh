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


#DATE=$(date '+%Y%m%d')
#FILENAME="${DATE}${DB_DUMP_FILE_SUFFIX}"

if [[ $SYNC_BY_SSH -eq 1 ]]; then
  AUTH="${SOURCE_SSH_USER}@${SOURCE_SSH_HOST}"
  SSH_DOOR="ssh -t ${AUTH}"

  FILENAME=$($SSH_DOOR "cd ${SOURCE_SSH_FOLDER} && bash ${SOURCE_DUMP_TOOL_SCRIPT};")
  FILENAME="${FILENAME%.tar.gz*}.tar.gz"

  SOURCE="${AUTH}:${SOURCE_SSH_FOLDER}/${FILENAME}"
  OWN_GROUP="www-data"
  DESTINATION="${DB_STORAGE_FOLDER}/"
  rsync -aO --chown=${USER}:${OWN_GROUP} ${SOURCE} ${DESTINATION}
#  OUTPUT="$(scp  ${AUTH}:${SOURCE_SSH_FOLDER}/storage/${FILENAME}.tar.gz ${DB_STORAGE_FOLDER}/)"


  bash bin/db-restore.sh ${FILENAME} \
      && bash bin/db-storage-manager.sh
  exit 0
fi

