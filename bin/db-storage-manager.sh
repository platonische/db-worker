#!/bin/bash

SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
cd $SCRIPTPATH
ROOTPATH=$( cd "$SCRIPTPATH/.." ; pwd -P )
cd $ROOTPATH

source ./src/loader.sh

COUNTER=0
FILES=`ls -t ${DB_STORAGE_FOLDER}/${DB_DUMP_FILE_MASK} | xargs -n 1 basename`

for FILE in $FILES; do
    COUNTER=$((COUNTER+1))
    if [ $COUNTER -gt ${DB_DUMP_MAX_FILES} ]; then
        echo "Remove file $FILE"
        rm  ${DB_STORAGE_FOLDER}/$FILE
    fi
done

#rm ${DB_STORAGE_FOLDER}/${DB_DUMP_UNPACKED_FILE_MASK} || true