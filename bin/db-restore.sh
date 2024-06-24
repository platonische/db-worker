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

if [[ $SILENT_MODE -eq 0 ]]; then
  while true; do
      read -p "Do you wish to continue? Yes[No] " yn
      case $yn in
          [Yy]* ) break;;
          [Nn]* ) exit;;
          * ) exit;;
      esac
  done
fi


PATTERN_TAR=".sql.tar.gz$"
if [[ $1 =~ ${PATTERN_TAR} ]]; then
  UNPACK_FILENAME=$1
  tar -xzf ${ROOTPATH}/$1 -C ${TMP_FOLDER}
  CROPPED_FILENAME=${UNPACK_FILENAME::${#UNPACK_FILENAME}-7}
  FILENAME=${TMP_FOLDER}/$(basename ${CROPPED_FILENAME})
else
  cp $1 ${TMP_FOLDER}
  FILENAME=${TMP_FOLDER}/$(basename $1)
fi

echo "FILENAME: $FILENAME"

bash bin/db-fixdefiner.sh $FILENAME || true

echo "Restore db"

mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASS} ${DB_NAME} < $FILENAME
echo "Db is restored.\n"

rm $FILENAME
echo "Temp cleared.\n"