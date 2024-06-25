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



FILENAME=$1

echo "FILENAME: $FILENAME"
FILENAME_TMP=${FILENAME}.tmp

echo "Fix definer"
sed -e "s/DEFINER\=[^ *]*\@[^ *]*/DEFINER=\`${DB_USER}\`\@\`\%\`/g" ${FILENAME} > ${FILENAME_TMP}

if [[ ${DO_FIX_MDEV_21178} -eq 1 ]]; then
  echo "Fix MDEV-21178 issue with new version dumped file"
  # Delete -> /*!999999\- enable the sandbox mode */
  tail -n +2 ${FILENAME_TMP}
fi


rm ${FILENAME}
cp ${FILENAME_TMP} ${FILENAME}
rm ${FILENAME_TMP}


echo "Dump fixed.\n"

exit 0;