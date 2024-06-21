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

echo "Fix definer"
echo "FILENAME: $1"

FILENAME=$1

echo "FILENAME: $FILENAME"
FILENAME_TMP=${FILENAME}.tmp
sed -e "s/DEFINER\=[^ *]*\@[^ *]*/DEFINER=\`${DB_USER}\`\@\`\%\`/g" ${FILENAME} > ${FILENAME_TMP}
rm ${FILENAME}
cp ${FILENAME_TMP} ${FILENAME}
rm ${FILENAME_TMP}


echo "Dump fixed.\n"

exit 0;