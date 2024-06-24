#!/bin/bash

SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
cd $SCRIPTPATH
ROOTPATH=$( cd "$SCRIPTPATH/.." ; pwd -P )
cd $ROOTPATH

source ./src/loader.sh

if [ -z "$FILENAME" ]; then
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
if [[ $FILENAME =~ ${PATTERN_TAR} ]]; then
  UNPACK_FILENAME=$FILENAME
  tar -xzf ${ROOTPATH}/$FILENAME -C ${TMP_FOLDER}
  CROPPED_FILENAME=${UNPACK_FILENAME::${#UNPACK_FILENAME}-7}
  FNAME=${TMP_FOLDER}/$(basename ${CROPPED_FILENAME})
else
  cp $FILENAME ${TMP_FOLDER}
  FNAME=${TMP_FOLDER}/$(basename $FILENAME)
fi

#echo "FILENAME: $FNAME"

bash bin/db-fixdefiner.sh $FNAME || true

echo "Restore db"

mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASS} ${DB_NAME} < $FNAME
echo "Db is restored.\n"

rm $FILENAME
echo "Temp cleared.\n"