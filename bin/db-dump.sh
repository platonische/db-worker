#!/bin/bash

SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
cd $SCRIPTPATH
ROOTPATH=$( cd "$SCRIPTPATH/.." ; pwd -P )
cd $ROOTPATH

source ./src/loader.sh

if [ -z "$1" ]; then
  echo "Failed. Add dump file name as argument"
  exit 1
fi

FILENAME=${DB_STORAGE_FOLDER}/$1

mysqldump -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASS}  ${DB_NAME} > ${FILENAME} \
	&& tar -czf ${FILENAME}.tar.gz -C $(dirname "${FILENAME}") $(basename "${FILENAME}") \
	&& rm ${FILENAME}

echo ${FILENAME}.tar.gz
echo "Dump is done."

bash bin/db-storage-manager.sh